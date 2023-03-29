import 'dart:io';

import 'package:correct_speech/infrastructure/file_structure_constants.dart';
import 'package:correct_speech/infrastructure/service/video_manager/video_manager.dart';
import 'package:path/path.dart';

class VideoManagerAndroid implements VideoManager {
  @override
  Future<void> move(File file, String albumName) async {
    final targetFilePath = join(
      FileStructureConstants.androidMediaPath,
      FileStructureConstants.appFolder,
      albumName,
      basename(file.path),
    );
    await file.copy(targetFilePath);
    await file.delete();
  }
}
