import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:flutter/material.dart';

class PreviousPodcastButton extends StatelessWidget {
  const PreviousPodcastButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: const Icon(
            Icons.skip_previous,
            size: 50,
          ),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}
