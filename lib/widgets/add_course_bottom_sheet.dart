import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';

class AddCourseBottomSheet extends StatefulWidget {
  const AddCourseBottomSheet({
    super.key,
    required this.isarService,
  });

  final IsarService isarService;

  @override
  State<AddCourseBottomSheet> createState() => _AddCourseBottomSheetState();
}

class _AddCourseBottomSheetState extends State<AddCourseBottomSheet> {
  final controllerAddCourse = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerAddCourse.dispose();
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
          Text('Give your new course a name',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: controllerAddCourse,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: 'Enter a course name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade600)),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButton(
            onTap: () {
              print('Button clicked');
              Future<int> future = widget.isarService
                  .saveCourse(Course(controllerAddCourse.text));

              controllerAddCourse.clear();
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
            buttonText: "Add a new course",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
