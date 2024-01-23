import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'notifiers/play_button_notifier.dart';
import 'notifiers/progress_notifier.dart';
import 'notifiers/repeat_button_notifier.dart';
import 'page_manager.dart';
import 'services/service_locator.dart';
import 'dart:math' as math;

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              RoundSeekerAlbumArt(), // CurrentSongTitle(),
              Playlist(),
              // AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundSeekerAlbumArt extends StatelessWidget {
  const RoundSeekerAlbumArt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ClipOval(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.black,
                  child: Image.asset(
                    'assets/images/demo_audiobook_cover_art.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const AudioSeeker(),
          ],
        );
      },
    );
  }
}

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

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return Row(
          children: [
            Text(formatDuration(value.current.inSeconds)),
            const Text("-"),
            Text(formatDuration(value.total.inSeconds)),
          ],
        );
      },
    );
  }
}

class AudioSeeker extends StatelessWidget {
  const AudioSeeker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return SongSeeker(duration: value.current);
      },
    );
  }
}

String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

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
              NextSongButton(),
            ],
          ),
        ],
      ),
    );
  }
}

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

class CurrentPodcastTitle extends StatelessWidget {
  const CurrentPodcastTitle({Key? key}) : super(key: key);

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
              style: const TextStyle(fontSize: 30),
            ));
      },
    );
  }
}

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

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                iconColor: MaterialStateProperty.all(Colors.black),
              ),
              icon: const Icon(Icons.play_arrow),
              iconSize: 55.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                iconColor: MaterialStateProperty.all(Colors.black),
              ),
              iconSize: 55.0,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: const Icon(Icons.skip_next, size: 50),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ChapterItem extends StatelessWidget {
  final int chapterNumber;
  final String chapterTitle;
  final int duration;

  const ChapterItem({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        title: Text(
          chapterTitle,
          style: TextStyle(color: Colors.purple[200]),
        ),
        subtitle: Text(
          '$duration seconds',
          style: TextStyle(color: Colors.grey[350]),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.music_note,
            color: Colors.purple,
            size: 30,
          ),
          onPressed: () {
            // TODO: implement play chapter logic
          },
        ),
      ),
    );
  }
}

class SongSeeker extends StatefulWidget {
  final Duration duration;

  const SongSeeker({Key? key, required this.duration}) : super(key: key);

  @override
  _SongSeekerState createState() => _SongSeekerState();
}

class _SongSeekerState extends State<SongSeeker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = 0.0;

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Start the animation when the widget is created
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: widget.duration,
      builder: (context, double value, child) {
        return SizedBox(
          height: 210,
          width: 210,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
            strokeWidth: 8.0,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
