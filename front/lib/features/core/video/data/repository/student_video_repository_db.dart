import 'dart:io';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/data/dao/student_video_dao.dart';
import 'package:correct_speech/features/core/video/data/mapper/student_video_mapper.dart';
import 'package:correct_speech/features/core/video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/domain/model/student_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';
import 'package:correct_speech/infrastructure/service/album_importer/album_importer.dart';

class StudentVideoRepositoryDb implements StudentVideoRepository {
  final StudentVideoDao _studentVideoDao;
  final StudentVideoMapper _studentVideoMapper;
  final AlbumImporter _albumImporter;

  StudentVideoRepositoryDb(
    this._albumImporter,
    this._studentVideoDao,
    this._studentVideoMapper,
  );

  @override
  Future<List<StudentVideo>> getStudentVideos(int studentId) async {
    final table = await _studentVideoDao.getStudentVideos(studentId);
    return table.map(_studentVideoMapper.fromEntry).toList();
  }

  @override
  Future<void> importVideos(List<Video> videos, RegisteredPerson student) async {
    for (final video in videos) {
      final importedPath = await _albumImporter.import(
        File(video.path),
        _createStudentAlbumName(student),
      );
      final importedMetadata = StudentVideo(
        path: importedPath,
        studentId: student.id,
      );
      final entry = _studentVideoMapper.toEntry(importedMetadata);
      await _studentVideoDao.insertStudentVideo(entry);
    }
  }

  String _createStudentAlbumName(RegisteredPerson student) {
    return '${student.fullName} ${student.id}';
  }
}
