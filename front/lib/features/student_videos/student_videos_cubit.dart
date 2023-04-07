import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student_video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/domain/interactor/video_ui_interactor.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentVideosCubit extends Cubit<BlocState?> {
  final StudentVideoRepository _repository;
  final VideoUICreator _creator;

  StudentVideosCubit(
    this._repository,
    this._creator,
  ) : super(null);

  StreamSubscription? _subscription;

  void init(RegisteredPerson student) async {
    _subscription = _repository.streamStudentVideos(student.id).listen((videos) async {
      final videosUI = await _creator.create(videos.map((video) => video.path));
      emit(BlocState(
        videos: videos,
        videosUI: videosUI,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

class BlocState {
  final List<RegisteredVideo> videos;
  final List<VideoUI> videosUI;

  BlocState({
    required this.videos,
    required this.videosUI,
  });
}
