import 'package:correct_speech/features/folder_distribution/injection.dart';
import 'package:injector/injector.dart';

Future<void> injectDependencies() async {
  final injector = Injector.appInstance;

  injectFolderDistributionDependencies();
}
