import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';
import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCreationCubit extends Cubit<BlocState> {
  final VideoCommentRepository _repository;

  CommentCreationCubit(
    this._repository,
  ) : super(BlocState.none);

  void createComment(VideoComment comment) async {
    emit(BlocState.waiting);
    await _repository.addComment(comment);
    emit(BlocState.saved);
  }
}

enum BlocState {
  none,
  waiting,
  saved,
}
