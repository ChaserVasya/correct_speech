import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';
import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<List<VideoComment>?> {
  final VideoCommentRepository _repository;

  CommentsCubit(
    this._repository,
  ) : super(null);

  //TODO add stream builder for db
  Future<void> init(RegisteredVideo video) async {
    final comments = await _repository.getCommentsOfVideo(video.id);
    emit(comments);
  }
}
