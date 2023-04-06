import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final VideoUI video;
  final void Function()? onTap;

  const VideoTile({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.memory(video.thumbnail),
      title: Text(video.name),
      onTap: onTap,
    );
  }
}
