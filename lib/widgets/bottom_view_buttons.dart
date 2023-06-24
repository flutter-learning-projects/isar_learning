import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/custom_button.dart';
import 'package:isar_learning/widgets/custom_dropdown.dart';

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
                            ?.copyWith(
                                color: Colors.grey.shade600, fontSize: 14))),
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
                controller: controllerAddCourse,
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
                            ?.copyWith(
                                color: Colors.grey.shade600, fontSize: 14))),
                style: GoogleFonts.dmSans(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black, fontSize: 14)),
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomDropDown(),
              const SizedBox(
                height: 35,
              ),
              CustomButton(
                onTap: () {
                  print('Button clicked');
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
      },
    );
  }
}
