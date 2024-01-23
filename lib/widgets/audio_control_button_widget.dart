import 'package:audio_book/widgets/audio_progress_bar_widget.dart';
import 'package:audio_book/widgets/current_chapter_title_widget.dart';
import 'package:audio_book/widgets/current_podcast_title.dart';
import 'package:audio_book/widgets/next_podcast_button_widget.dart';
import 'package:audio_book/widgets/play_button_widget.dart';
import 'package:audio_book/widgets/previous_podcast_button_widget.dart';
import 'package:flutter/material.dart';

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 210,
      width: 210,
      child: Column(
        children: [
          CurrentPodcastTitle(),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentChapterTitle(),
                AudioProgressBar(),
                // Text("0:32 - 4:18"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PreviousPodcastButton(),
              PlayButton(),
              NextPodcastButton(),
            ],
          ),
        ],
      ),
    );
  }
}
