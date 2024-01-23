import 'dart:io';

import 'package:audio_book/models/podcast_model.dart';
import 'package:flutter/services.dart';

abstract class PlaylistRepository {
  // Future<List<Map<String, String>>> fetchInitialPlaylist();
  // Future<Map<String, String>> fetchAnotherSong();
  Future<List<Podcast>> getPodcasts();
}

class DemoPlaylist extends PlaylistRepository {
  // @override
  // Future<List<Map<String, String>>> fetchInitialPlaylist() async {
  //   // return List.generate(length, (index) =>

  //   var trucks = {
  //     'id': _songIndex.toString().padLeft(3, '0'),
  //     'title': 'Song $_songIndex',
  //     'album': 'SoundHelix',
  //     'url':
  //         'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3'
  //   };

  //   return trucks;
  // }

  // @override
  // Future<Map<String, String>> fetchAnotherSong() async {
  //   return _nextSong();
  // }

  // var _songIndex = 0;
  // static const _maxSongNumber = 16;

  // Map<String, String> _nextSong() {
  //   _songIndex = (_songIndex % _maxSongNumber) + 1;
  //   return {
  //     'id': _songIndex.toString().padLeft(3, '0'),
  //     'title': 'Song $_songIndex',
  //     'album': 'SoundHelix',
  //     'url':
  //         'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3',
  //   };
  // }

  @override
  Future<List<Podcast>> getPodcasts() async {
    List<Podcast> podcasts = [];

    try {
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

      // Iterate through each file and create Podcast objects
      for (var fileName in fileNames) {
        final String audioPath = 'assets/podcasts/$fileName';
        final File file = File(audioPath);

        var t = file.uri.toString();
        Podcast podcast = Podcast(
          title: fileName,
          host: 'Unknown Host',
          contributors: ['Unknown Contributor'],
          durationInSeconds: 0,
          genre: 'Unknown Genre',
          podcastUri:
              //  t,
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
          isFavorite: false,
        );

        podcasts.add(podcast);
      }
    } catch (e) {
      print('Error loading podcasts: $e');
    }

    return podcasts;
  }
}
