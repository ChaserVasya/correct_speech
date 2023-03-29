import 'package:correct_speech/features/core/app_folder.dart';
import 'package:correct_speech/features/folder_distribution/export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injector/injector.dart';

void injectFolderDistribution() {
  final injector = Injector.appInstance;

  injector.registerDependency(VideoInfoMapper.new);

  injector.registerDependency(
    () => SourceVideoInteractor(
      injector.get(),
      FilePicker.platform,
    ),
  );

  injector.registerDependency(
    () => FolderDistributionBloc(
      appFolder: AppFolder(),
      sourceVideoInteractor: injector.get(),
    ),
  );
}
