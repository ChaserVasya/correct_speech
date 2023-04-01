import 'package:correct_speech/infrastructure/db/db_names.dart';
import 'package:correct_speech/infrastructure/db/local_database.dart';
import 'package:injector/injector.dart';

Future<void> injectDb() async {
  final db = await $FloorLocalDatabase.databaseBuilder(DBNames.localDatabaseName).build();

  final injector = Injector.appInstance;
  injector.registerSingleton(() => db.database);
  injector.registerSingleton(() => db.personDao);
  injector.registerSingleton(() => db.personDao);
}
