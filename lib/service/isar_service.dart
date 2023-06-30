import 'package:isar/isar.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/data/student.dart';
import 'package:isar_learning/data/teacher.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<int> saveCourse(Course newCourse) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.courses.putSync(newCourse));
  }

  Future<int> saveTeacher(Teacher newTeacher) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.teachers.putSync(newTeacher));
  }

  Future<int> saveStudent(Student newStudent) async {
    final isar = await db;
    var status =
        isar.writeTxnSync<int>(() => isar.students.putSync(newStudent));
    // isar.courses.sy
    return status;
  }

  Future<bool> deleteTeacher(Teacher teacher) async {
    final isar = await db;
    return isar.writeTxnSync<bool>(() => isar.teachers.deleteSync(teacher.id));

    // isar.courses.sy
  }

  Future<List<Course>> getAllCourses() async {
    final isar = await db;
    return await isar.courses.where().findAll();
  }

  Future<List<Teacher>> getAllTeachers() async {
    final isar = await db;
    return await isar.teachers.where().findAll();
  }

  Future<List<Student>> getAllStudents() async {
    final isar = await db;
    return await isar.students.where().findAll();
  }

  Stream<List<Course>> listenToCourse() async* {
    final isar = await db;
    yield* isar.courses.where().watch();
  }

  Stream<List<Student>> listenToStudent() async* {
    final isar = await db;
    yield* isar.students.where().watch();
  }

  Stream<List<Teacher>> listenToTeacher() async* {
    final isar = await db;
    yield* isar.teachers.where().watch();
  }

  Future<List<Student>> getStudentsFor(Course course) async {
    final isar = await db;
    return await isar.students
        .filter()
        .courses((q) => q.idEqualTo(course.id))
        .findAll();
  }

  Future<Teacher?> getTeahcersFor(Course course) async {
    final isar = await db;
    final teacher = await isar.teachers
        .filter()
        .course((q) => q.idEqualTo(course.id))
        .findFirst();
    return teacher;
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([CourseSchema, TeacherSchema, StudentSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
