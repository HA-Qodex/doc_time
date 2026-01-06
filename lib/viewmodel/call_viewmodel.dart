import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doc_time/model/call_model.dart';
import 'package:doc_time/services/agora_service.dart';
import 'package:doc_time/services/permission_service.dart';
import 'package:doc_time/util/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallViewmodel extends AsyncNotifier<CallModel> {
  late final AgoraService _agoraService;
  final _permissionService = PermissionService();

  @override
  FutureOr<CallModel> build() async {
    _agoraService = AgoraService();
    await _permissionService.requestPermission();
    await _agoraService.initialize();
    await _agoraService.setupLocalVideo();
    _addEventHandler();
    joinCall();
    ref.onDispose(() async {
      await _agoraService.leaveChannel();
      state = AsyncData(CallModel());
    });
    return const CallModel();
  }

  void _addEventHandler() {
    _agoraService.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (_, __) {
          state = AsyncData(
            state.value!.copyWith(isJoined: true, engine: _agoraService.engine),
          );
        },
        onUserJoined: (_, uid, __) {
          state = AsyncData(
            state.value!.copyWith(remoteUid: uid, engine: _agoraService.engine),
          );
        },
        onUserOffline: (_, __, reason) {
          debugPrint("User offline: $reason");
          state = AsyncData(state.value!.copyWith(remoteUid: null));
        },
      ),
    );
  }

  Future<void> joinCall() async {
    await _agoraService.joinChannel(
      token: AppUtils.token,
      channelId: AppUtils.channelName,
      uid: 0,
    );
  }

  Future<void> leaveCall() async {
    await _agoraService.leaveChannel();
    state = AsyncData(CallModel());
  }

  void toggleControlVisible() {
    state = AsyncData(
      state.value!.copyWith(showController: !state.value!.showController),
    );
  }

  void toggleVideo()async{
    final current = state.value!;
    _agoraService.engine.muteLocalVideoStream(!current.isVideoOff);
    _agoraService.engine.enableLocalVideo(current.isVideoOff);
    state = AsyncData(
      state.value!.copyWith(
        isVideoOff: !current.isVideoOff,
        remoteUid: current.remoteUid
      ),
    );
  }

  void switchCamera() {
    final current = state.value!;
    _agoraService.engine.switchCamera();
    state = AsyncData(
      current.copyWith(
        remoteUid: current.remoteUid,
        deviceCamera: current.deviceCamera == DeviceCamera.front
            ? DeviceCamera.back
            : DeviceCamera.front,
      ),
    );
  }

  void toggleMute() async {
    final current = state.value!;
    _agoraService.engine.muteLocalAudioStream(!current.isMuted);
    state = AsyncData(
      current.copyWith(isMuted: !current.isMuted, remoteUid: current.remoteUid),
    );
  }

  Future<bool> leaveVideoCall() async {
    await _agoraService.leaveChannel();
    state = AsyncData(CallModel());
    return true;
  }
}
