import 'package:correct_speech/features/core/export.dart';
import 'package:floor/floor.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM PersonTable')
  Future<List<PersonEntry>> getAllPersons();

  @Query('SELECT * FROM PersonTable WHERE id = :id')
  Future<PersonEntry?> getPerson(int id);

  @update
  Future<void> updatePerson(PersonEntry person);

  @insert
  Future<void> insertPerson(PersonEntry person);

  @delete
  Future<void> deletePerson(PersonEntry person);
}
