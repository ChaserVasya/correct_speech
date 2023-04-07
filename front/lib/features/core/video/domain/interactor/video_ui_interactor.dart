import 'dart:typed_data';

import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoUICreator {
  Future<List<VideoUI>> create(Iterable<String> videoPaths) async {
    final videos = <VideoUI>[];
    for (final path in videoPaths) {
      videos.add(VideoUI(
        path: path,
        thumbnail: await _createThumbnail(path),
      ));
    }
    return videos;
  }

  Future<Uint8List> _createThumbnail(String filePath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: filePath,
      maxHeight: 250,
      maxWidth: 250,
      quality: 50,
    );
    return thumbnail!;
  }
}
