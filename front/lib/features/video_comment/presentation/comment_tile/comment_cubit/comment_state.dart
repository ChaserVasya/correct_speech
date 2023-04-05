import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';

typedef BlocStateConstructor<T extends BlocState> = T Function({
  required List<VideoComment> comments,
  required bool editingEnabled,
});

abstract class BlocState {
  final List<VideoComment> comments;
  final bool editingEnabled;

  BlocState({
    required this.comments,
    required this.editingEnabled,
  });

  T copyWith<T extends BlocState>(
    BlocStateConstructor<T> constructor, {
    List<VideoComment>? comments,
    bool? editingEnabled,
  }) {
    return constructor(
      comments: comments ?? this.comments,
      editingEnabled: editingEnabled ?? this.editingEnabled,
    );
  }
}

class BlocStateLoading extends BlocState {
  BlocStateLoading({
    required super.comments,
    required super.editingEnabled,
  });
}

class BlocStateMain extends BlocState {
  BlocStateMain({
    required super.comments,
    required super.editingEnabled,
  });
}
