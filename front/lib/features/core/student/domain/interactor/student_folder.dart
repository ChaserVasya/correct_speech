import 'dart:io';

import 'package:correct_speech/features/core/student/export.dart';
import 'package:correct_speech/features/core/video/export.dart';
import 'package:correct_speech/infrastructure/service/video_manager/video_manager.dart';

class StudentFolder {
  final Student student;

  final VideoManager _videoManager;

  StudentFolder({
    required this.student,
    required VideoManager videoManager,
  }) : _videoManager = videoManager;

  Future<void> importVideos(List<VideoInfo> videosInfo) async {
    for (final videoInfo in videosInfo) {
      await _videoManager.move(File(videoInfo.path), _createStudentAlbumName());
    }
  }

  String _createStudentAlbumName() {
    return '${student.fullName} ${student.id}';
  }
}
