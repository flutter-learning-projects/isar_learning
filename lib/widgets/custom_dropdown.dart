import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';

class CustomDropDown extends StatefulWidget {
  final ValueChanged<Course?> onChanged;

  const CustomDropDown({super.key, required this.onChanged});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // List<String>? spinnerItems;
  List<Course>? courses;
  Course? _course;
  IsarService isarService = IsarService();

  @override
  void initState() {
    isarService.getAllCourses().then((value) {
      setState(() {
        // spinnerItems = value.map((e) => e.title).toList();
        courses = value;
        _course = value[0];
        // dropdownValue = spinnerItems?[0];
        widget.onChanged.call(_course);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: _course == null
          ? const CircularProgressIndicator()
          : DropdownButtonHideUnderline(
              child: DropdownButton<Course>(
                isExpanded: true,
                value: _course,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green,
                  size: 16,
                ),
                iconSize: 24,
                elevation: 16,
                style: GoogleFonts.dmSans(
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ).copyWith(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade300,
                ),
                onChanged: (Course? data) {
                  setState(() {
                    _course = data;
                    widget.onChanged.call(data);
                  });
                },
                items: courses?.map<DropdownMenuItem<Course>>((Course value) {
                  return DropdownMenuItem<Course>(
                    value: value,
                    child: Text(value.title),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
