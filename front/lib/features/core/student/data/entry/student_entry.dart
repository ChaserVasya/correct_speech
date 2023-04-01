import 'package:floor/floor.dart';

@entity
class StudentEntry {
  @primaryKey
  final int personId;

  StudentEntry(this.personId);
}
