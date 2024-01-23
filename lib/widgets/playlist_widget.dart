import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:audio_book/widgets/chapter_item_widget.dart';
import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ChapterItem(
                chapterNumber: index + 1,
                chapterTitle: 'Chapter ${index + 1}',
                duration: 300,
              );
            },
          );
        },
      ),
    );
  }
}
