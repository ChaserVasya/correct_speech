import 'dart:io';

import 'package:correct_speech/infrastructure/file_structure_constants.dart';
import 'package:correct_speech/infrastructure/service/album_importer/album_importer.dart';
import 'package:path/path.dart';

class AlbumImporterAndroid implements AlbumImporter {
  @override
  Future<String> import(File file, String albumName) async {
    final targetFilePath = join(
      FileStructureConstants.androidMediaPath,
      FileStructureConstants.appFolder,
      albumName,
      basename(file.path),
    );
    await file.copy(targetFilePath);
    await file.delete();
    return targetFilePath;
  }
}
