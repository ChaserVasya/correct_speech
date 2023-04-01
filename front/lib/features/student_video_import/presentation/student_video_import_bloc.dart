import 'dart:async';
import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/student_video_import/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentVideoImportBloc extends Bloc<StudentVideoImportEvent, StudentVideoImportState> {
  final SourceVideoInteractor _sourceVideoInteractor;
  final AppFolder _appFolder;

  StudentVideoImportBloc({
    required SourceVideoInteractor sourceVideoInteractor,
    required AppFolder appFolder,
  })  : _sourceVideoInteractor = sourceVideoInteractor,
        _appFolder = appFolder,
        super(StudentVideoImportStateMain()) {
    on(_onEventPickVideos);
    on(_onEventMoveVideos);
    on(_onEventStudentSelected);
  }

  FutureOr<void> _onEventPickVideos(
    StudentVideoImportEventPickVideos event,
    Emitter<StudentVideoImportState> emit,
  ) async {
    final state = this.state as StudentVideoImportStateMain;

    final pickedVideos = await _sourceVideoInteractor.pickVideos();
    emit(state..videosInfo = pickedVideos);
  }

  FutureOr<void> _onEventMoveVideos(
    StudentVideoImportEventMoveVideos event,
    Emitter<StudentVideoImportState> emit,
  ) async {
    final state = this.state as StudentVideoImportStateMain;
    final studentOnVideo = state.studentOnVideo;

    if (studentOnVideo == null) {
      emit(StudentVideoImportStateStudentNotSelected());
      emit(state);
      return;
    }

    await _appFolder.folderOf(studentOnVideo).importVideos(state.videosInfo);

    emit(state..videosInfo = []);
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
  final Student? selectedStudent;

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
  List<VideoInfo> videosInfo;
  Student? studentOnVideo;

  StudentVideoImportStateMain({
    this.videosInfo = const [],
    this.studentOnVideo,
  });
}

class StudentVideoImportStateStudentNotSelected extends StudentVideoImportState {}
