import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:flutter/material.dart';

class CurrentChapterTitle extends StatelessWidget {
  const CurrentChapterTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
          ),
        );
      },
    );
  }
}
