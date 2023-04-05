import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['authorId'],
      parentColumns: ['id'],
      entity: PersonEntry,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class VideoEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int authorId;
  final String path;

  const VideoEntry({
    this.id,
    required this.authorId,
    required this.path,
  });
}
