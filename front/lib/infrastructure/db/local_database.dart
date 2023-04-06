import 'dart:async';
import 'package:correct_speech/features/core/person/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/person/data/dao/related_persons_dao.dart';
import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
import 'package:correct_speech/features/core/student/data/dao/student_dao.dart';
import 'package:correct_speech/features/core/student/data/entry/student_entry.dart';
import 'package:correct_speech/features/core/video/data/dao/video_dao.dart';
import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:correct_speech/features/video_comment/data/dao/video_comment_dao.dart';
import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  StudentEntry,
  PersonEntry,
  RelatedPersonsEntry,
  VideoEntry,
  VideoCommentEntry,
])
abstract class LocalDatabase extends FloorDatabase {
  StudentDao get studentDao;
  PersonDao get personDao;
  RelatedPersonsDao get relatedPersonsDao;
  VideoDao get videoDao;
  VideoCommentDao get videoCommentDao;
}
