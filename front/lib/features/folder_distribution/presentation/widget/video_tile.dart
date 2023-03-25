import 'package:correct_speech/features/core/export.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final VideoInfo video;
  final bool isSelected;
  final VoidCallback onPressed;

  const VideoTile({
    super.key,
    required this.video,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Stack(
        children: [
          Image.memory(video.preview),
          Icon(isSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank),
          Text(video.name),
        ],
      ),
    );
  }
}
