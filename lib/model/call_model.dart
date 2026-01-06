import 'package:agora_rtc_engine/agora_rtc_engine.dart';
enum DeviceCamera { front, back }


class CallModel {
  final bool isJoined;
  final int? remoteUid;
  final bool isMuted;
  final bool isVideoOff;
  final bool showController;
  final DeviceCamera deviceCamera;
  final RtcEngine? engine;

  const CallModel({
    this.isJoined = false,
    this.remoteUid,
    this.isMuted = false,
    this.isVideoOff = false,
    this.showController = true,
    this.deviceCamera = DeviceCamera.front,
    this.engine,
  });

  CallModel copyWith({
    bool? isJoined,
    int? remoteUid,
    bool? isMuted,
    bool? isVideoOff,
    bool? showController,
    DeviceCamera? deviceCamera,
    RtcEngine? engine,
  }) {
    return CallModel(
      isJoined: isJoined ?? this.isJoined,
      remoteUid: remoteUid,
      isMuted: isMuted ?? this.isMuted,
      showController: showController ?? this.showController,
      isVideoOff: isVideoOff ?? this.isVideoOff,
      deviceCamera: deviceCamera ?? this.deviceCamera,
      engine: engine ?? this.engine,
    );
  }
}
