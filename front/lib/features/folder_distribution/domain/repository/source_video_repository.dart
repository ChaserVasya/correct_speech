import 'package:correct_speech/features/core/export.dart';

abstract class SourceVideoRepository {
  String? sourcePath;

  Future<void> init();

  void setSourcePath(String newVideoSourcePath);

  Future<List<VideoInfo>> getVideosInfo();
}
