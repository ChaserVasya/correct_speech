import 'dart:async';
import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/folder_distribution/domain/repository/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderDistributionBloc extends Bloc<FolderDistributionEvent, FolderDistributionState> {
  final VideoRepository _videoRepository;

  FolderDistributionBloc({
    required VideoRepository videoRepository,
  })  : _videoRepository = videoRepository,
        super(const FolderDistributionStateInit()) {
    on(_onVideoPressedEvent);
    on(_onInitEvent);
  }

  FutureOr<void> _onVideoPressedEvent(
    FolderDistributionEventVideoPressed event,
    Emitter<FolderDistributionState> emit,
  ) {
    final state = this.state as FolderDistributionStateMain;
    state.selectedVideos[event.selectedVideoIndex] = !state.selectedVideos[event.selectedVideoIndex];
    emit(state);
  }

  FutureOr<void> _onInitEvent(
    FolderDistributionEvent event,
    Emitter<FolderDistributionState> emit,
  ) async {
    final videosInfo = await _videoRepository.getVideosInfo();

    emit(FolderDistributionStateMain(
      videos: videosInfo,
      videoSourcePath: _videoRepository.videoSourcePath,
      selectedVideos: List.filled(videosInfo.length, false),
    ));
  }
}

abstract class FolderDistributionEvent {
  const FolderDistributionEvent();
}

class FolderDistributionEventVideoPressed extends FolderDistributionEvent {
  final int selectedVideoIndex;

  const FolderDistributionEventVideoPressed({required this.selectedVideoIndex});
}

abstract class FolderDistributionState {
  const FolderDistributionState();
}

class FolderDistributionStateInit extends FolderDistributionState {
  const FolderDistributionStateInit();
}

class FolderDistributionStateMain extends FolderDistributionState {
  final List<VideoInfo> videos;
  final List<bool> selectedVideos;
  String videoSourcePath;

  FolderDistributionStateMain({
    required this.videos,
    required this.selectedVideos,
    required this.videoSourcePath,
  });
}
