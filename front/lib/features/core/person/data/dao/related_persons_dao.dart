import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class RelatedPersonsDao {
  @Query('SELECT * FROM RelatedPersons')
  Future<Iterable<RelatedPersonsEntry>> getAllRelatedPersons();

  @Query('SELECT * FROM RelatedPersons WHERE id1 = :id')
  Future<Iterable<RelatedPersonsEntry>> getRelatedToPerson(int id);

  @update
  Future<void> updateRelatedPersons(RelatedPersonsEntry persons);

  @insert
  Future<void> insertRelatedPersons(Iterable<RelatedPersonsEntry> persons);

  @delete
  Future<void> deleteRelatedPersons(Iterable<RelatedPersonsEntry> persons);
}
