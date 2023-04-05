import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

class VideoMapper {
  RegisteredVideo toDomain(VideoEntry entry) {
    return RegisteredVideo(
      id: entry.id!,
      path: entry.path,
      authorId: entry.authorId,
    );
  }

  VideoEntry toEntry(RegisteredVideo video) {
    return VideoEntry(
      id: video.id,
      path: video.path,
      authorId: video.authorId,
    );
  }

  VideoEntry toInsertEntry(Video video, int authorId) {
    return VideoEntry(
      id: null,
      path: video.path,
      authorId: authorId,
    );
  }
}
