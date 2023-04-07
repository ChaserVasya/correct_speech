import 'package:correct_speech/feature_framework/model/feature.dart';
import 'package:correct_speech/features/student_videos/students_screen.dart';
import 'package:correct_speech/features/students_info/students_info_screen.dart';
import 'package:correct_speech/features/video_import/presentation/student_video_import_screen.dart';
import 'package:correct_speech/infrastructure/assets/feature_icons.dart';

final features = [
  Feature(
    name: 'Импорт видео',
    iconPath: FeatureIcons.studentVideoImport,
    mainScreenBuilder: (_) => const StudentVideoImportScreen(),
  ),
  Feature(
    name: 'Комментарии к видео',
    iconPath: FeatureIcons.videoComment,
    mainScreenBuilder: (_) => const StudentOnVideoSelectionScreen(),
  ),
  Feature(
    name: 'Студенты',
    iconPath: FeatureIcons.studentEditing,
    mainScreenBuilder: (_) => const StudentsInfoScreen(),
  ),
];
