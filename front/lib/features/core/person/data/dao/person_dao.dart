import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Persons')
  Future<List<PersonEntry>> getAllPersons();

  @Query('SELECT * FROM Persons')
  Stream<List<PersonEntry>> streamAllPersons();

  @Query('SELECT * FROM Persons WHERE id IN (:ids)')
  Future<List<PersonEntry>> getPersonsByIds(List<int> ids);

  @Query('SELECT * FROM Persons WHERE id IN (:ids)')
  Stream<List<PersonEntry>> streamPersonsByIds(List<int> ids);

  @Query('SELECT * FROM Persons WHERE id = :id')
  Future<PersonEntry?> getPersonById(int id);

  @update
  Future<void> updatePerson(PersonEntry person);

  @insert
  Future<int> insertPerson(PersonEntry person);

  @delete
  Future<void> deletePerson(PersonEntry person);
}
