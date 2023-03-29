import 'package:correct_speech/features/inject.dart';

import 'infrastructure/inject.dart';

Future<void> injectDependencies() async {
  await injectInfrastructure();

  injectFeatures();
}
