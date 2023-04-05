import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

class RegisteredVideo extends Video implements Registered {
  @override
  final int id;
  final int authorId;

  const RegisteredVideo({
    required this.id,
    required this.authorId,
    required super.path,
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        ...super.props,
      ];
}
