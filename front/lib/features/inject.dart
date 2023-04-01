import 'package:correct_speech/features/core/inject.dart';
import 'package:correct_speech/features/student_video_import/injection.dart';

void injectFeatures() {
  injectFeaturesCore();

  injectStudentVideoImport();
}
