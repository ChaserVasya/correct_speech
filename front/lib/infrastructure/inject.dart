import 'package:correct_speech/infrastructure/db/inject.dart';

Future<void> injectInfrastructure() async {
  await injectDb();
}
