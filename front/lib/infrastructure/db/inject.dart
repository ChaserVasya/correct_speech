import 'package:correct_speech/infrastructure/db/db_names.dart';
import 'package:correct_speech/infrastructure/db/local_database.dart';
import 'package:injector/injector.dart';

Future<void> injectDb() async {
  final db = await $FloorLocalDatabase.databaseBuilder(DBNames.localDatabaseName).build();

  final register = Injector.appInstance.registerSingleton;

  register(() => db.database);

  register(() => db.personDao);
  register(() => db.studentDao);
  register(() => db.relatedPersonsDao);
  register(() => db.videoDao);
  register(() => db.videoCommentDao);
}
