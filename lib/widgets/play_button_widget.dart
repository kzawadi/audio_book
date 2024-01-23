import 'package:audio_book/notifiers/play_button_notifier.dart';
import 'package:audio_book/page_manager.dart';
import 'package:audio_book/services/service_locator.dart';
import 'package:flutter/material.dart';

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
