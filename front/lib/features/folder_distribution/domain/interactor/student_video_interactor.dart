import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/infrastructure/service/file_mover.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class StudentVideoInteractor {
  final StudentRepository _studentRepository;
  final FileMover _fileMover;

  StudentVideoInteractor(
    StudentRepository studentRepository,
    FileMover fileMover,
  )   : _studentRepository = studentRepository,
        _fileMover = fileMover;

  Future<void> moveToStudentFolder(Student student, List<VideoInfo> videosInfo) async {
    for (final videoInfo in videosInfo) {
      final studentFolder = '${student.fullName} ${student.id}';
      await _fileMover.move(
        sourcePath: videoInfo.path,
        destinationPath: studentFolder,
      );
           final a =  await PhotoManager.getAssetPathList();
           a[1].
    }
  }

  Future<void> 
}
