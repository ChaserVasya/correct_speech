import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/folder_distribution/export.dart';
import 'package:injector/injector.dart';

Future<void> injectFolderDistributionDependencies() async {
  final injector = Injector.appInstance;

  injector.registerDependency(
    () => FolderDistributionBloc(
      videoRepository: injector.get<VideoRepository>(),
    ),
  );
}
