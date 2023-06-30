import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/data/teacher.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';
import 'package:isar_learning/widgets/custom_dropdown.dart';

class AddTeacherBottomSheet extends StatefulWidget {
  final Teacher? teacher;
  const AddTeacherBottomSheet(
      {super.key, required this.isarService, required this.teacher});

  final IsarService isarService;

  @override
  State<AddTeacherBottomSheet> createState() => _AddTeacherBottomSheetState();
}

class _AddTeacherBottomSheetState extends State<AddTeacherBottomSheet> {
  Course? _course;

  final controllerAddTeacher = TextEditingController();

  @override
  void initState() {
    setState(() {
      controllerAddTeacher.text = widget.teacher?.name ?? '';
      _course = widget.teacher?.course.value;
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerAddTeacher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Add new teacher',
              style: GoogleFonts.dmSans(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ).copyWith(color: Colors.black)),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controllerAddTeacher,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: 'Enter teacher name',
                hintStyle: GoogleFonts.dmSans(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey.shade600, fontSize: 14))),
            style: GoogleFonts.dmSans(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black, fontSize: 14)),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropDown(
            course: _course,
            onChanged: (Course? data) {
              _course = data;
              print('current course: ${_course?.title}');
            },
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButton(
            onTap: () {
              var teacher = widget.teacher ?? Teacher();

              teacher.name = controllerAddTeacher.text;
              teacher.course.value = _course;
              Future<int> future = widget.isarService.saveTeacher(teacher);

              controllerAddTeacher.clear();

              future.then((int value) {
                // Invoked when the future is completed with a value.
                print(
                    'value : $value'); // The successor is completed with the value 42.
              }, onError: (e) {
                print('error: $e');
                // Invoked when the future is completed with an error.
              });
              Navigator.of(context).pop();
            },
            buttonText: "Add Teacher",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
