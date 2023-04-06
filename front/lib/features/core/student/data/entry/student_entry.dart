import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'Students',
  foreignKeys: [
    ForeignKey(
      childColumns: ['personId'],
      parentColumns: ['id'],
      onDelete: ForeignKeyAction.cascade,
      entity: PersonEntry,
    )
  ],
)
class StudentEntry {
  @primaryKey
  final int personId;

  StudentEntry(this.personId);
}
