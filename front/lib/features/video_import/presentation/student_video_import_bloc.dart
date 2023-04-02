import 'dart:async';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/domain/interactor/video_ui_interactor.dart';
import 'package:correct_speech/features/core/video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:correct_speech/features/video_import/domain/interactor/source_video_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentVideoImportBloc extends Bloc<StudentVideoImportEvent, StudentVideoImportState> {
  final SourceVideoInteractor _sourceVideoInteractor;
  final VideoUICreator _videoUICreator;
  final StudentVideoRepository _studentVideoRepository;

  StudentVideoImportBloc(
    this._sourceVideoInteractor,
    this._videoUICreator,
    this._studentVideoRepository,
  ) : super(StudentVideoImportStateMain()) {
    on(_onEventPickVideos);
    on(_onEventMoveVideos);
    on(_onEventStudentSelected);
  }

  FutureOr<void> _onEventPickVideos(
    StudentVideoImportEventPickVideos event,
    Emitter<StudentVideoImportState> emit,
  ) async {
    final state = this.state as StudentVideoImportStateMain;

    final pickedVideoPaths = await _sourceVideoInteractor.pickVideos();
    final pickedVideos = await _videoUICreator.create(pickedVideoPaths);
    emit(state..videos = pickedVideos);
  }

  FutureOr<void> _onEventMoveVideos(
    StudentVideoImportEventMoveVideos event,
    Emitter<StudentVideoImportState> emit,
  ) async {
    final state = this.state as StudentVideoImportStateMain;
    final studentOnVideo = state.studentOnVideo;

    if (studentOnVideo == null) {
      //TODO check what will be when emit two states syncly
      emit(StudentVideoImportStateStudentNotSelected());
      emit(state);
      return;
    }

    await _studentVideoRepository.importVideos(state.videos, studentOnVideo);
    emit(state..videos = []);
  }

  FutureOr<void> _onEventStudentSelected(
    StudentVideoImportEventStudentSelected event,
    Emitter<StudentVideoImportState> emit,
  ) {
    final state = this.state as StudentVideoImportStateMain;
    state.studentOnVideo = event.selectedStudent;
    emit(state);
  }
}

abstract class StudentVideoImportEvent {
  const StudentVideoImportEvent();
}

class StudentVideoImportEventStudentSelected extends StudentVideoImportEvent {
  final RegisteredPerson? selectedStudent;

  StudentVideoImportEventStudentSelected(this.selectedStudent);
}

class StudentVideoImportEventPickVideos extends StudentVideoImportEvent {}

class StudentVideoImportEventMoveVideos extends StudentVideoImportEvent {}

abstract class StudentVideoImportState {
  const StudentVideoImportState();
}

class StudentVideoImportStateInit extends StudentVideoImportState {
  const StudentVideoImportStateInit();
}

class StudentVideoImportStateMain extends StudentVideoImportState {
  List<VideoUI> videos;
  RegisteredPerson? studentOnVideo;

  StudentVideoImportStateMain({
    this.videos = const [],
    this.studentOnVideo,
  });
}

class StudentVideoImportStateStudentNotSelected extends StudentVideoImportState {}
