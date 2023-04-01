import 'package:correct_speech/features/core/export.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final VideoInfo video;

  const VideoTile({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.memory(video.thumbnail),
        Text(video.name),
      ],
    );
  }
}
