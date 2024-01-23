import 'package:audio_book/widgets/audio_control_button_widget.dart';
import 'package:audio_book/widgets/playlist_widget.dart';
import 'package:audio_book/widgets/round_seeker-album_art.dart';
import 'package:flutter/material.dart';
import 'page_manager.dart';
import 'services/service_locator.dart';

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
              RoundSeekerAlbumArt(),
              Playlist(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
