import 'dart:typed_data';

import 'package:correct_speech/features/core/video/domain/model/video.dart';
import 'package:equatable/equatable.dart';

class VideoUI extends Video with EquatableMixin {
  final Uint8List thumbnail;

  const VideoUI({
    required this.thumbnail,
    required super.path,
  });

  @override
  List<Object?> get props => [
        path,
      ];
}
