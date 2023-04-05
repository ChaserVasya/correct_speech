import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class Video with EquatableMixin {
  final String path;
  String get name => basenameWithoutExtension(path);

  const Video({
    required this.path,
  });

  @override
  List<Object?> get props => [
        path,
      ];

  Video copyWith(String? path) {
    return Video(
      path: path ?? this.path,
    );
  }
}
