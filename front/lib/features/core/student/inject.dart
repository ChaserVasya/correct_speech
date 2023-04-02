import 'package:correct_speech/features/core/student/data/repository/student_repository_db.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:correct_speech/features/core/student/presentation/student_selection_bottomsheet/student_selection_bloc.dart';
import 'package:injector/injector.dart';

void injectStudent() {
  final injector = Injector.appInstance;
  final getImpl = injector.get;

  injector.registerDependency<StudentRepository>(() => StudentRepositoryDB(getImpl(), getImpl(), getImpl(), getImpl()));
  injector.registerDependency(() => StudentSelectionBloc(getImpl()));
}
