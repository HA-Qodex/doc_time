import 'package:doc_time/model/call_model.dart';
import 'package:doc_time/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlButtons extends ConsumerWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref1) {
    final showController = ref1.watch(callProvider);
    return AnimatedSlide(
      offset: showController.value?.showController ?? false
          ? const Offset(0, 0)
          : const Offset(0, 1),
      duration: Duration(milliseconds: 500),
      child: Container(
        height: 120,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer(
              builder: (context, ref, _) {
                final isMuted = ref.watch(
                  callProvider.select((state) => state.value?.isMuted ?? true),
                );
                return FloatingActionButton(
                  heroTag: "micToggle",
                  onPressed: () {
                    ref.read(callProvider.notifier).toggleMute();
                  },
                  child: Icon(isMuted ? Icons.mic_off : Icons.mic, size: 30),
                );
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                final isVideoOff = ref.watch(
                  callProvider.select(
                    (state) => state.value?.isVideoOff ?? true,
                  ),
                );
                return FloatingActionButton(
                  heroTag: "videoToggle",
                  onPressed: () {
                    ref.read(callProvider.notifier).toggleVideo();
                  },
                  child: Icon(
                    isVideoOff ? Icons.videocam_off : Icons.videocam,
                    size: 30,
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                return FloatingActionButton(
                  heroTag: "switchCamera",
                  onPressed: () {
                    ref.read(callProvider.notifier).switchCamera();
                  },
                  child: const Icon(Icons.change_circle_outlined, size: 30),
                );
              },
            ),
            FloatingActionButton(
              heroTag: "endCall",
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                if (await ref1.read(callProvider.notifier).leaveVideoCall()) {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Icon(Icons.call_end_rounded, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
