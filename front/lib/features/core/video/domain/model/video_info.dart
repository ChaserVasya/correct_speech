import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class VideoInfo extends Equatable {
  final String path;
  final Uint8List thumbnail;
  String get name => basenameWithoutExtension(path);

  const VideoInfo({
    required this.path,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [path];
}
