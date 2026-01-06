import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doc_time/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoteVideoView extends ConsumerWidget {
  const RemoteVideoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(callProvider);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        ref.read(callProvider.notifier).toggleControlVisible();
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.purpleAccent],
          ),
        ),
        child: provider.when(
          data: (value) => value.remoteUid != null
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: value.engine!,
                    canvas: VideoCanvas(uid: value.remoteUid),
                  ),
                )
              : Center(
                  child: Text(
                    'Waiting for remote user to join...',
                    textAlign: TextAlign.center,
                  ),
                ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
