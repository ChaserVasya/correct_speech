import 'package:correct_speech/feature_framework/model/feature.dart';
import 'package:correct_speech/features/video_import/presentation/student_video_import_screen.dart';
import 'package:correct_speech/infrastructure/assets/feature_icons.dart';

final featureStudentVideoImport = Feature(
  name: 'Распределение видео',
  iconPath: FeatureIcons.studentVideoImport,
  routes: {
    '/': (_) => const StudentVideoImportScreen(),
  },
);
