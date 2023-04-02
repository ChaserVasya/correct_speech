abstract class VideoCommentRepository {
  Future<List<String>> getComments(List<String> videoPaths);

  Future<void> addComment({String videoPath, String comment});

  Future<void> updateComment({String videoPath, String comment});

  Future<void> deleteComment(String videoPath);
}
