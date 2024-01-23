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
      builder: (_, value, __) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1),
          duration: value.total,
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
      },
    );
  }
}
