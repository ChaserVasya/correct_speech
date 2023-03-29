import 'dart:async';
import 'package:correct_speech/features/core/student/export.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Student])
abstract class LocalDatabase extends FloorDatabase {
  StudentDao get personDao;
}
