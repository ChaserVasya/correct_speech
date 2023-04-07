import 'package:correct_speech/features/core/person/data/mapper/person_mapper.dart';
import 'package:correct_speech/features/core/person/data/mapper/sex_mapper.dart';
import 'package:correct_speech/features/core/person/data/repository/person_repository_db.dart';
import 'package:correct_speech/features/core/person/domain/formatter/name_formatter.dart';
import 'package:correct_speech/features/core/person/domain/formatter/phone_formatter.dart';
import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/validator/name_validator.dart';
import 'package:correct_speech/features/core/person/domain/validator/phone_validator.dart';
import 'package:correct_speech/features/core/person/presentation/model/sex_ui_mapper.dart';
import 'package:correct_speech/features/core/student/data/mapper/student_mapper.dart';
import 'package:correct_speech/features/core/student/data/repository/student_repository_db.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:correct_speech/features/core/student/presentation/students_list/students_cubit.dart';
import 'package:correct_speech/features/core/student_video/data/repository/student_video_repository_db.dart';
import 'package:correct_speech/features/core/student_video/domain/interface/student_video_repository.dart';
import 'package:correct_speech/features/core/video/data/mapper/video_mapper.dart';
import 'package:correct_speech/features/core/video/data/repository/video_repository_db.dart';
import 'package:correct_speech/features/core/video/domain/interactor/video_ui_interactor.dart';
import 'package:correct_speech/features/core/video/domain/interface/video_repository.dart';
import 'package:correct_speech/features/person_screen/person_editing/person_editing_cubit/person_editing_cubit.dart';
import 'package:correct_speech/features/person_screen/related_persons/related_persons_cubit/related_persons_cubit.dart';
import 'package:correct_speech/features/person_tile/person_tile_cubit.dart';
import 'package:correct_speech/features/student_creation/student_creation_cubit/student_creation_cubit.dart';
import 'package:correct_speech/features/student_videos/student_videos_cubit.dart';
import 'package:correct_speech/features/video_comment/data/repository/video_comment_repository.dart';
import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_creation/comment_creation_cubit.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_editing/comment_editing_cubit.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_tile/comment_cubit/comment_cubit.dart';
import 'package:correct_speech/features/video_comment/presentation/comments_list/comments_cubit.dart';
import 'package:injector/injector.dart';

import 'video_import/domain/interactor/source_video_interactor.dart';
import 'video_import/presentation/student_video_import_bloc.dart';

final _register = Injector.appInstance.registerDependency;
final _getImpl = Injector.appInstance.get;

Future<void> injectFeatures() async {
  _injectDomain();
  _injectMappers();
  _injectRepositories();
  _injectInteractors();
  _injectBlocs();
}

void _injectDomain() {
  _register(() => NameFormatter());
  _register(() => PhoneFormatter());
  _register(() => NameValidator());
  _register(() => PhoneValidator());
}

void _injectRepositories() {
  _register<PersonRepository>(() => PersonRepositoryDb(_getImpl(), _getImpl(), _getImpl()));
  _register<StudentRepository>(() => StudentRepositoryDB(_getImpl(), _getImpl(), _getImpl()));
  _register<StudentVideoRepository>(() => StudentVideoRepositoryDb(_getImpl(), _getImpl()));
  _register<VideoRepository>(() => VideoRepositoryDb(_getImpl(), _getImpl()));
  _register<VideoCommentRepository>(() => VideoCommentRepositoryDB(_getImpl(), _getImpl()));
}

void _injectMappers() {
  _register(() => StudentMapper());
  _register(() => SexMapper());
  _register(() => SexUIMapper());
  _register(() => VideoMapper());
  _register(() => PersonMapper(_getImpl()));
}

void _injectInteractors() {
  _register(() => VideoUICreator());
  _register(() => SourceVideoInteractor(_getImpl()));
}

void _injectBlocs() {
  _register(() => StudentsCubit(_getImpl()));
  _register(() => PersonEditingCubit(_getImpl()));
  _register(() => RelatedPersonsCubit(_getImpl()));
  _register(() => PersonCubit(_getImpl()));
  _register(() => StudentCreationCubit(_getImpl()));
  _register(() => StudentVideosCubit(_getImpl(), _getImpl()));
  _register(() => CommentCreationCubit(_getImpl()));
  _register(() => CommentEditingCubit(_getImpl()));
  _register(() => CommentCubit(_getImpl()));
  _register(() => CommentsCubit(_getImpl()));
  _register(() => StudentVideoImportCubit(_getImpl(), _getImpl(), _getImpl()));
}
