import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/data/student.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';
import 'package:isar_learning/widgets/custom_multiselection.dart';

class AddStudentBottomSheet extends StatefulWidget {
  final IsarService isarService;

  const AddStudentBottomSheet({super.key, required this.isarService});

  @override
  State<AddStudentBottomSheet> createState() => _AddStudentBottomSheetState();
}

class _AddStudentBottomSheetState extends State<AddStudentBottomSheet> {
  List<Course>? courses;
  Course? _course;

  final controllerAddStudent = TextEditingController();

  @override
  void initState() {
    widget.isarService.getAllCourses().then((value) {
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
          Text('Add new student',
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
          _chipsList(courses
                  ?.where((element) => element.isSelected == true)
                  .toList() ??
              List.empty()),
          CustomButton(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomMultiSelection(
                        courses: courses,
                        coureseCallback: (value) {
                          setState(() {
                            courses = value;
                          });
                        },
                      ));
            },
            buttonText: "Select Courses",
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onTap: () {
              var student = Student();
              var selectedCourses =
                  courses?.where((element) => element.isSelected);

              student.name = controllerAddStudent.text;
              student.courses.addAll(selectedCourses ?? List.empty());
              controllerAddStudent.clear();
              if (selectedCourses != null) {
                Future<int> future = widget.isarService.saveStudent(student);
                future.then((int value) {
                  // Invoked when the future is completed with a value.
                  print(
                      'value : $value'); // The successor is completed with the value 42.
                }, onError: (e) {
                  print('error: $e');
                  // Invoked when the future is completed with an error.
                });
              }

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

  Widget _chipsList(List<Course> list) {
    return Column(
      children: [
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children:
              list.map((e) => _buildChip(e.title, Colors.blueAccent)).toList(),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 1.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.only(left: 6, right: 8, top: 6, bottom: 6),
    );
  }
}
