import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';
import 'package:isar_learning/widgets/custom_multiselection.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddStudentBottomSheet extends StatefulWidget {
  final IsarService isarService;

  const AddStudentBottomSheet({super.key, required this.isarService});

  @override
  State<AddStudentBottomSheet> createState() => _AddStudentBottomSheetState();
}

class _AddStudentBottomSheetState extends State<AddStudentBottomSheet> {
  IsarService isarService = IsarService();
  List<Course>? courses;
  Course? _course;

  final controllerAddStudent = TextEditingController();

  @override
  void initState() {
    isarService.getAllCourses().then((value) {
      setState(() {
        // spinnerItems = value.map((e) => e.title).toList();
        courses = value;
        // dropdownValue = spinnerItems?[0];
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerAddStudent.dispose();
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
            controller: controllerAddStudent,
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
          CustomButton(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomMultiSelection(
                        courses: courses,
                      ));
            },
            buttonText: "Select Courses",
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onTap: () {
              Navigator.of(context).pop();
            },
            buttonText: "Add Student",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
