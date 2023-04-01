import 'package:correct_speech/features/core/app_folder.dart';
import 'package:correct_speech/features/student_video_import/export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injector/injector.dart';

void injectStudentVideoImport() {
  final injector = Injector.appInstance;

  injector.registerDependency(VideoInfoMapper.new);

  injector.registerDependency(
    () => SourceVideoInteractor(
      injector.get(),
      FilePicker.platform,
    ),
  );

  injector.registerDependency(
    () => StudentVideoImportBloc(
      appFolder: AppFolder(),
      sourceVideoInteractor: injector.get(),
    ),
  );
}
