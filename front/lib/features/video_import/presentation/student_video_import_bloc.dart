import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student_video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/domain/interactor/video_ui_interactor.dart';
import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:correct_speech/features/video_import/domain/interactor/source_video_interactor.dart';
import 'package:correct_speech/infrastructure/helper/nullable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentVideoImportCubit extends Cubit<BlocState> {
  final SourceVideoInteractor _sourceVideoInteractor;
  final VideoUICreator _videoUICreator;
  final StudentVideoRepository _studentVideoRepository;

  StudentVideoImportCubit(
    this._sourceVideoInteractor,
    this._videoUICreator,
    this._studentVideoRepository,
  ) : super(const BlocStateMain(videos: []));

  void pickVideos() async {
    emit(state.copyWith(BlocStateLoading.new));

    final pickedVideoPaths = await _sourceVideoInteractor.pickVideos();
    final pickedVideos = await _videoUICreator.create(pickedVideoPaths);

    var videosUnion = (state.videos + pickedVideos).toSet().toList();

    emit(state.copyWith(
      BlocStateMain.new,
      videos: videosUnion,
    ));
  }

  void moveVideos() async {
    emit(state.copyWith(BlocStateLoading.new));

    await _studentVideoRepository.importVideos(state.videos, state.studentOnVideo!);
    emit(state.copyWith(BlocStateMain.new, videos: []));
  }

  void studentSelected(RegisteredPerson selectedStudent) {
    emit(state.copyWith(BlocStateMain.new, studentOnVideo: Nullable(selectedStudent)));
  }
}

typedef StateConstructor<T extends BlocState> = T Function({
  required List<VideoUI> videos,
  RegisteredPerson? studentOnVideo,
});

abstract class BlocState {
  final List<VideoUI> videos;
  final RegisteredPerson? studentOnVideo;

  const BlocState({
    required this.videos,
    this.studentOnVideo,
  });

  T copyWith<T extends BlocState>(
    StateConstructor<T> constructor, {
    List<VideoUI>? videos,
    Nullable<RegisteredPerson?>? studentOnVideo,
  }) {
    return constructor(
      videos: videos ?? this.videos,
      studentOnVideo: (studentOnVideo != null) ? studentOnVideo.value : this.studentOnVideo,
    );
  }
}

class BlocStateMain extends BlocState {
  const BlocStateMain({required super.videos, super.studentOnVideo});
}

class BlocStateLoading extends BlocState {
  const BlocStateLoading({required super.videos, super.studentOnVideo});
}
