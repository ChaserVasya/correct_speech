import 'package:correct_speech/features/core/video/domain/model/video.dart';

class VideoComment {
  final Video metadata;
  final String comment;

  const VideoComment({
    required this.metadata,
    required this.comment,
  });
}
