import 'package:isar/isar.dart';
import 'package:isar_learning/data/course.dart';

part 'student.g.dart';

@Collection()
class Student {
  Id id = Isar.autoIncrement;
  late String name;
  final courses = IsarLinks<Course>();
}
