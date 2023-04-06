import 'dart:io';

import 'package:correct_speech/infrastructure/service/album_importer/impl/album_importer_android.dart';
import 'package:correct_speech/infrastructure/service/album_importer/impl/album_importer_ios.dart';

abstract class AlbumImporter {
  Future<String> import(File file, String albumName);

  static AlbumImporter get platform {
    if (Platform.isAndroid) return AlbumImporterAndroid();
    if (Platform.isIOS) return AlbumImporterIOS();
    throw Exception();
  }
}
