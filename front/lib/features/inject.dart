import 'package:correct_speech/features/core/inject.dart';
import 'package:correct_speech/features/folder_distribution/injection.dart';

void injectFeatures() {
  injectFeaturesCore();

  injectFolderDistribution();
}
