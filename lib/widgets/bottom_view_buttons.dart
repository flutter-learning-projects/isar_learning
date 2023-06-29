import 'package:flutter/material.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/add_course_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_student_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_teacher_bottom_sheet.dart';
import 'package:isar_learning/widgets/custom_button.dart';

class BottomViewButtons extends StatefulWidget {
  final IsarService isarService;
  const BottomViewButtons({super.key, required this.isarService});

  @override
  State<BottomViewButtons> createState() => _BottomViewButtonsState();
}

class _BottomViewButtonsState extends State<BottomViewButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CustomButton(
              onTap: () {
                _showBottomSheetAddCourse(context, widget.isarService);
              },
              buttonText: 'Add a new course',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CustomButton(
              onTap: () {
                _showBottomSheetAddTeacher(context, widget.isarService);
              },
              buttonText: 'Add Teacher',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CustomButton(
              onTap: () {
                _showBottomSheetAddAddStudent(context, widget.isarService);
              },
              buttonText: 'Add Student',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }

  Future<void> _showBottomSheetAddCourse(
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

  Future<void> _showBottomSheetAddTeacher(
      BuildContext context, IsarService isarService) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddTeacherBottomSheet(
          isarService: isarService,
        );
      },
    );
  }

  Future<void> _showBottomSheetAddAddStudent(
      BuildContext context, IsarService isarService) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddStudentBottomSheet(
          isarService: isarService,
        );
      },
    );
  }
}
