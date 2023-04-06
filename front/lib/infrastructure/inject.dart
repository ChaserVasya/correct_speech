import 'package:correct_speech/infrastructure/db/inject.dart';
import 'package:correct_speech/infrastructure/service/inject.dart';

Future<void> injectInfrastructure() async {
  await injectDb();
  injectServices();
}
