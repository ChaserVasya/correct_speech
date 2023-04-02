import 'dart:typed_data';

import 'package:correct_speech/features/core/video/domain/model/video.dart';

class VideoUI extends Video {
  final Uint8List thumbnail;

  VideoUI({
    required this.thumbnail,
    required super.path,
  });
}
