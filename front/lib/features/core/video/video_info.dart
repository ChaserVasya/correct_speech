import 'dart:typed_data';

import 'package:path/path.dart';

class VideoInfo {
  final String path;
  final Uint8List thumbnail;
  String get name => basenameWithoutExtension(path);

  const VideoInfo({
    required this.path,
    required this.thumbnail,
  });

  @override
  bool operator ==(Object other) {
    if (other is! VideoInfo) {
      return false;
    }

    return path == other.path;
  }

  @override
  int get hashCode => Object.hashAll([path]);
}
