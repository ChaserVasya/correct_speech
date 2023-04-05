import 'dart:io';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student_video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/domain/interface/video_repository.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';
import 'package:correct_speech/infrastructure/service/album_importer/album_importer.dart';

class StudentVideoRepositoryDb implements StudentVideoRepository {
  final AlbumImporter _albumImporter;
  final VideoRepository _videoRepository;

  StudentVideoRepositoryDb(
    this._albumImporter,
    this._videoRepository,
  );

  @override
  Future<List<RegisteredVideo>> getStudentVideos(int studentId) async {
    return await _videoRepository.getVideosByAuthor(studentId);
  }

  @override
  Future<void> importVideos(List<Video> videos, RegisteredPerson student) async {
    for (final video in videos) {
      final importedPath = await _albumImporter.import(File(video.path), _createStudentAlbumName(student));
      await _videoRepository.addVideo(video.copyWith(importedPath), student);
    }
  }

  String _createStudentAlbumName(RegisteredPerson student) {
    return '${student.fullName} ${student.id}';
  }
}
