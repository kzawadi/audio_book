import 'package:audio_book/models/podcast_model.dart';
import 'package:flutter/foundation.dart';

abstract class PlaylistRepository {
  Future<List<Podcast>> getPodcasts();
}

class DemoPlaylist extends PlaylistRepository {
  // List all asset files in the 'assets/audio' folder

  List<String> fileNames = [
    'chapter_0.mp3',
    'chapter_1.mp3',
    'chapter_2.mp3',
    'chapter_3.mp3',
    'chapter_4.mp3',
    'chapter_5.mp3',
    'chapter_6.mp3',
  ];
  @override
  Future<List<Podcast>> getPodcasts() async {
    List<Podcast> podcasts = [];

    try {
      // Iterate through each file and create Podcast objects
      for (var fileName in fileNames) {
        final String audioPath = 'assets/podcasts/$fileName';

        Podcast podcast = Podcast(
          title: fileName,
          host: 'Unknown Host',
          contributors: ['Unknown Contributor'],
          genre: 'Unknown Genre',
          podcastUri: audioPath,
          isFavorite: false,
        );

        podcasts.add(podcast);
      }
    } catch (e) {
      debugPrint('Error loading podcasts: $e');
    }

    return podcasts;
  }
}
