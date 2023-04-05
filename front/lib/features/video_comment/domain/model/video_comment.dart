import 'package:correct_speech/infrastructure/helper/nullable.dart';
import 'package:equatable/equatable.dart';

class VideoComment extends Equatable {
  final int? id;
  final int videoId;
  final String comment;

  const VideoComment({
    this.id,
    required this.videoId,
    required this.comment,
  });

  VideoComment copyWith({
    Nullable<int?>? id,
    int? videoId,
    String? comment,
  }) {
    return VideoComment(
      id: (id != null) ? id.value : this.id,
      videoId: videoId ?? this.videoId,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        id,
        videoId,
        comment,
      ];
}
