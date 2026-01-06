import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doc_time/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalVideoView extends ConsumerWidget {
  const LocalVideoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(callProvider);
    return provider.when(
      data: (data) => Visibility(
        visible: data.isVideoOff == false,
        child: SizedBox(
          height: 200,
          width: 150,
          child: data.engine != null
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: data.engine!,
                    canvas: VideoCanvas(
                      uid: 0,
                      renderMode: RenderModeType.renderModeHidden,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'Waiting for remote user to join...',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
      error: (error, _) => Text(error.toString()),
      loading: () => CircularProgressIndicator.adaptive(),
    );
  }
}
