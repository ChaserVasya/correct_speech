import 'dart:async';
import 'package:correct_speech/features/core/person/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/person/data/dao/related_persons_dao.dart';
import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
import 'package:correct_speech/features/core/student/data/dao/student_dao.dart';
import 'package:correct_speech/features/core/student/data/entry/student_entry.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_database.g.dart'; // the generated code will be there

//TODO check table names are equal to queries
@Database(version: 1, entities: [StudentEntry, PersonEntry, RelatedPersonsEntry])
abstract class LocalDatabase extends FloorDatabase {
  StudentDao get studentDao;
  PersonDao get personDao;
  RelatedPersonsDao get relatedPersonsDao;
}
