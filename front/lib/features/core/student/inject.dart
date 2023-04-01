import 'package:correct_speech/features/core/student/export.dart';
import 'package:injector/injector.dart';

void injectStudent() {
  final injector = Injector.appInstance;
  final getImpl = injector.get;

  injector.registerDependency<StudentRepository>(() => StudentRepositoryDB(getImpl(), getImpl(), getImpl(), getImpl()));
  injector.registerDependency(() => StudentSelectionBloc(getImpl()));
}
