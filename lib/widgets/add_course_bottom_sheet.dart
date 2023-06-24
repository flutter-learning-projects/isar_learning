import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';

class AddCourseBottomSheet extends StatelessWidget {
  const AddCourseBottomSheet({
    super.key,
    required this.controllerAddCourse,
    required this.isarService,
  });

  final TextEditingController controllerAddCourse;
  final IsarService isarService;

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
              style: GoogleFonts.dmSans(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ).copyWith(color: Colors.black)),
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
            height: 35,
          ),
          CustomButton(
            onTap: () {
              print('Button clicked');
              Future<int> future =
                  isarService.saveCourse(Course(controllerAddCourse.text));

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
