import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['studentId'],
      parentColumns: ['id'],
      entity: PersonEntry,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class StudentVideoEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int studentId;

  final String path;

  const StudentVideoEntry({
    this.id,
    required this.studentId,
    required this.path,
  });
}
