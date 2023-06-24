import 'package:flutter/material.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/add_course_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_teacher_bottom_sheet.dart';
import 'package:isar_learning/widgets/custom_button.dart';

class BottomViewButtons extends StatefulWidget {
  const BottomViewButtons({super.key});

  @override
  State<BottomViewButtons> createState() => _BottomViewButtonsState();
}

class _BottomViewButtonsState extends State<BottomViewButtons> {
  final controllerAddCourse = TextEditingController();
  final controllerAddTeacher = TextEditingController();
  IsarService isarService = IsarService();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerAddCourse.dispose();
    super.dispose();
  }

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
                _showBottomSheetAddCourse(context);
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
                _showBottomSheetAddTeacher(context);
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
              onTap: () {},
              buttonText: 'Add Studen',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }

  Future<void> _showBottomSheetAddCourse(BuildContext context) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddCourseBottomSheet(
            controllerAddCourse: controllerAddCourse, isarService: isarService);
      },
    );
  }

  Future<void> _showBottomSheetAddTeacher(BuildContext context) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddTeacherBottomSheet(
          controllerAddTeacher: controllerAddTeacher,
          isarService: isarService,
        );
      },
    );
  }
}
