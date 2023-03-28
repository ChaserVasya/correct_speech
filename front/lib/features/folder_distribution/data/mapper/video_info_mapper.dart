import 'dart:typed_data';

import 'package:correct_speech/features/core/export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoInfoMapper {
  Future<List<VideoInfo>> fromFilePickerResult(FilePickerResult result) async {
    final videosInfo = <VideoInfo>[];
    for (final filePath in result.paths) {
      videosInfo.add(VideoInfo(
        path: filePath!,
        thumbnail: await _createThumbnail(filePath),
      ));
    }
    return videosInfo;
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
