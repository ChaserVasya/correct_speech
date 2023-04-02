import 'package:floor/floor.dart';

import 'person_entry.dart';

//TODO check can I use composite childColumn foreign key opposite to two foreign keys
@Entity(
  tableName: 'RelatedPersons',
  primaryKeys: ['id1', 'id2'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['id1'],
      parentColumns: ['id'],
      entity: PersonEntry,
    ),
    ForeignKey(
      childColumns: ['id2'],
      parentColumns: ['id'],
      entity: PersonEntry,
    )
  ],
)
class RelatedPersonsEntry {
  final int id1;
  final int id2;

  RelatedPersonsEntry(this.id1, this.id2);
}
