import 'package:isar/isar.dart';
import 'package:isar_learning/data/student.dart';
import 'package:isar_learning/data/teacher.dart';
part 'course.g.dart';

@Collection()
class Course {
  Id id = Isar.autoIncrement;
  final String title;

  @ignore
  bool isSelected = false;

  Course(this.title);

  @Backlink(to: "course")
  final teacher = IsarLink<Teacher>();

  @Backlink(to: "courses")
  final students = IsarLinks<Student>();
}
