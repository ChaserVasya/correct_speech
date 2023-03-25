import 'dart:typed_data';

class VideoInfo {
  final String name;
  final Uint8List preview;

  const VideoInfo({
    required this.name,
    required this.preview,
  });
}
