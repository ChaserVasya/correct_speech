import 'package:correct_speech/features/video_comment/data/dao/video_comment_dao.dart';
import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';

class VideoCommentRepositoryDB implements VideoCommentRepository {
  final VideoCommentDao _videoCommentDao;

  @override
  Future<List<String>> getComments(List<String> videoPaths) {}

  @override
  Future<void> addComment({String videoPath, String comment}) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComment(String videoPath) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment({String videoPath, String comment}) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
