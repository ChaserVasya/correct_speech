import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailCreator {
  Future<Uint8List> create(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      maxHeight: 250,
      maxWidth: 250,
      quality: 30,
    );
    return thumbnail!;
  }
}
