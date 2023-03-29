import 'package:correct_speech/features/core/student/export.dart';
import 'package:injector/injector.dart';

void injectStudent() {
  final injector = Injector.appInstance;

  injector.registerDependency<StudentRepository>(() => StudentRepositoryDB(
        injector.get(),
      ));

  injector.registerDependency(() => StudentSelectionBloc(
        injector.get(),
      ));
}
