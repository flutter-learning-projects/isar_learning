import 'package:flutter/material.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/add_course_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_student_bottom_sheet.dart';
import 'package:isar_learning/widgets/add_teacher_bottom_sheet.dart';
import 'package:isar_learning/utils/bottomsheets.dart';
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
                BottomSheets.showBottomSheetAddCourse(
                    context, widget.isarService);
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
                BottomSheets.showBottomSheetAddTeacher(
                    context, widget.isarService, null);
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
                BottomSheets.showBottomSheetAddAddStudent(
                    context, widget.isarService, null);
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
}
