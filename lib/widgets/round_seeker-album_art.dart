import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:audio_book/widgets/audio_seeker_widget.dart';
import 'package:flutter/material.dart';

class RoundSeekerAlbumArt extends StatelessWidget {
  const RoundSeekerAlbumArt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const AudioSeeker(),
            ClipOval(
              child: Container(
                width: 240.0,
                height: 240.0,
                color: Colors.black,
                child: Image.asset(
                  'assets/images/demo_audiobook_cover_art.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
