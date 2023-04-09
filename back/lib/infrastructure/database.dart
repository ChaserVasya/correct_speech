import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

@DriftDatabase(tables: [
Comments,
Persons,
RelatedPersons,
Students,
Videos,
])
class Database extends _$Database {
  Database () : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}