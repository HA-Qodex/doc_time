import 'package:doc_time/widget/control_buttons.dart';
import 'package:doc_time/widget/local_video_view.dart';
import 'package:doc_time/widget/remote_video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCallView extends ConsumerWidget {
  const VideoCallView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _){
          if(didPop) return;
          Navigator.of(context).pop();
        },
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          maintainBottomViewPadding: true,
          child: Stack(
            children: [
              RemoteVideoView(),
              Positioned(top: 40, right: 10, child: LocalVideoView()),
              Positioned(bottom: 0, left: 0, right: 0, child: ControlButtons())
            ],
          ),
        ),
      )
    );
  }
}
