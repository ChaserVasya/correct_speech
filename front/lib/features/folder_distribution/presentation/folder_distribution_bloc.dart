import 'dart:async';
import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/folder_distribution/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderDistributionBloc extends Bloc<FolderDistributionEvent, FolderDistributionState> {
  final SourceVideoInteractor _sourceVideoInteractor;
  final AppFolder _appFolder;

  FolderDistributionBloc({
    required SourceVideoInteractor sourceVideoInteractor,
    required AppFolder appFolder,
  })  : _sourceVideoInteractor = sourceVideoInteractor,
        _appFolder = appFolder,
        super(FolderDistributionStateMain()) {
    on(_onEventPickVideos);
    on(_onEventMoveVideos);
    on(_onEventStudentSelected);
  }

  FutureOr<void> _onEventPickVideos(
    FolderDistributionEventPickVideos event,
    Emitter<FolderDistributionState> emit,
  ) async {
    final state = this.state as FolderDistributionStateMain;

    final pickedVideos = await _sourceVideoInteractor.pickVideos();
    emit(state..videosInfo = pickedVideos);
  }

  FutureOr<void> _onEventMoveVideos(
    FolderDistributionEventMoveVideos event,
    Emitter<FolderDistributionState> emit,
  ) async {
    final state = this.state as FolderDistributionStateMain;
    final studentOnVideo = state.studentOnVideo;

    if (studentOnVideo == null) {
      emit(FolderDistributionStateStudentNotSelected());
      emit(state);
      return;
    }

    await _appFolder.folderOf(studentOnVideo).importVideos(state.videosInfo);

    emit(state..videosInfo = []);
  }

  FutureOr<void> _onEventStudentSelected(
    FolderDistributionEventStudentSelected event,
    Emitter<FolderDistributionState> emit,
  ) {
    final state = this.state as FolderDistributionStateMain;
    state.studentOnVideo = event.selectedStudent;
    emit(state);
  }
}

abstract class FolderDistributionEvent {
  const FolderDistributionEvent();
}

class FolderDistributionEventStudentSelected extends FolderDistributionEvent {
  final Student? selectedStudent;

  FolderDistributionEventStudentSelected(this.selectedStudent);
}

class FolderDistributionEventPickVideos extends FolderDistributionEvent {}

class FolderDistributionEventMoveVideos extends FolderDistributionEvent {}

abstract class FolderDistributionState {
  const FolderDistributionState();
}

class FolderDistributionStateInit extends FolderDistributionState {
  const FolderDistributionStateInit();
}

class FolderDistributionStateMain extends FolderDistributionState {
  List<VideoInfo> videosInfo;
  Student? studentOnVideo;

  FolderDistributionStateMain({
    this.videosInfo = const [],
    this.studentOnVideo,
  });
}

class FolderDistributionStateStudentNotSelected extends FolderDistributionState {}
