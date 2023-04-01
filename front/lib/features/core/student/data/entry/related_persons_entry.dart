import 'package:floor/floor.dart';

import 'person_entry.dart';

//TODO check how to create composite PK
//TODO check can I use composite childColumn foreign key opposite to two foreign keys
@Entity(foreignKeys: [
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
])
class RelatedPersonsEntry {
  @primaryKey
  final int id1;
  @primaryKey
  final int id2;

  RelatedPersonsEntry(this.id1, this.id2);
}
