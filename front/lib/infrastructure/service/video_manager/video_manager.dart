import 'dart:io';

abstract class VideoManager {
  Future<void> move(File file, String albumName);
}
