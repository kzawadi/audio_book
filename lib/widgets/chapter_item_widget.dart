import 'package:flutter/material.dart';

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
