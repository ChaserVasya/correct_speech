import 'package:floor/floor.dart';

import 'person_entry.dart';

@Entity(
  tableName: 'RelatedPersons',
  primaryKeys: ['id1', 'id2'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['id1'],
      parentColumns: ['id'],
      entity: PersonEntry,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['id2'],
      parentColumns: ['id'],
      entity: PersonEntry,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class RelatedPersonsEntry {
  final int id1;
  final int id2;

  const RelatedPersonsEntry(this.id1, this.id2);
}
