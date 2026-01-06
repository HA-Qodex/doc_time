import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doc_time/util/app_utils.dart';

class AgoraService {
  late final RtcEngine engine;

  Future<void> initialize() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(
      const RtcEngineContext(
        appId: AppUtils.appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  Future<void> setupLocalVideo()async{
    await engine.enableVideo();
    await engine.startPreview();
  }

  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
  }) async {
    await engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: ChannelMediaOptions(
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster
      ),
    );
  }

  Future<void> leaveChannel()async{
    await engine.stopPreview();
    await engine.leaveChannel();
    await engine.release();
  }
}
