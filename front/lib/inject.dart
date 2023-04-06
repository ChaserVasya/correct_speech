import 'package:correct_speech/features/inject.dart';
import 'package:correct_speech/infrastructure/inject.dart';

Future<void> injectApp() async {
  await injectInfrastructure();
  await injectFeatures();
}
