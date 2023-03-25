import 'package:correct_speech/features/core/export.dart';

abstract class VideoRepository {
  final String videoSourcePath;

  const VideoRepository({required this.videoSourcePath});

  Future<List<VideoInfo>> getVideosInfo();
}
