import 'package:audio_book/notifiers/play_button_notifier.dart';
import 'package:audio_book/notifiers/progress_notifier.dart';
import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:flutter/material.dart';

class AudioSeeker extends StatelessWidget {
  const AudioSeeker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, progressValue, __) {
        final playbackState = pageManager.playButtonNotifier.value;

        if (playbackState == ButtonState.playing) {
          print(
              'Playing: ${progressValue.current.inMinutes}/${progressValue.total.inMinutes}'
                  .toString());
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: progressValue.current.inSeconds.toDouble() / 240,
              end: progressValue.total.inSeconds.toDouble() / 240,
            ),
            duration: progressValue.total,
            builder: (context, value, _) => SizedBox(
              height: 260,
              width: 260,
              child: CircularProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[850],
                strokeCap: StrokeCap.round,
                strokeWidth: 5,
                color: Colors.purple,
              ),
            ),
          );
        } else {
          // Return a static widget (e.g., an empty container) if not playing
          return Container();
        }
      },
    );
  }
}
