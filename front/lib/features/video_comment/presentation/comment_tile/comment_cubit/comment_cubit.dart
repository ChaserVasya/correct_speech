import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_state.dart';

class CommentCubit extends Cubit<BlocState?> {
  final VideoCommentRepository _commentRepository;

  CommentCubit(
    this._commentRepository,
  ) : super(null);

  void init(int videoId) async {
    final comments = await _commentRepository.getCommentsOfVideo(videoId);
    emit(BlocStateMain(
      comments: comments,
      editingEnabled: false,
    ));
  }

  void deleteComment(int commentId) async {
    await _commentRepository.deleteComment(commentId);
  }
}
