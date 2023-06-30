import 'package:flutter/material.dart';
import 'package:isar_learning/data/student.dart';
import 'package:isar_learning/data/teacher.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/add_course_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_student_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_teacher_bottom_sheet.dart';

class BottomSheets {
 

  static Future<void> showBottomSheetAddCourse(
      BuildContext context, IsarService isarService) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddCourseBottomSheet(isarService: isarService);
      },
    );
  }

 static Future<void> showBottomSheetAddTeacher(
      BuildContext context, IsarService isarService,Teacher? teacher) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddTeacherBottomSheet(
          isarService: isarService,
          teacher: teacher
        );
      },
    );
  }
  static Future<void> showBottomSheetAddAddStudent(
      BuildContext context, IsarService isarService,Student? student) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddStudentBottomSheet(
          isarService: isarService,
          student: student,
        );
      },
    );
  }
}
