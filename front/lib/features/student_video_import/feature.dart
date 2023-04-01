import 'package:correct_speech/feature_framework/export.dart';
import 'package:correct_speech/features/student_video_import/export.dart';
import 'package:correct_speech/infrastructure/assets/feature_icons.dart';

final featureStudentVideoImport = Feature(
  name: 'Распределение видео',
  iconPath: FeatureIcons.studentVideoImport,
  routes: {
    '/': (_) => const StudentVideoImportScreen(),
  },
);
