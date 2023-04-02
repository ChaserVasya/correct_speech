import 'package:path/path.dart';

class Video {
  final String path;
  String get name => basenameWithoutExtension(path);

  const Video({
    required this.path,
  });
}
