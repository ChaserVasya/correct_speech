import 'dart:io';

abstract class AlbumImporter {
  Future<String> import(File file, String albumName);
}
