import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/teacher.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/utils/bottomsheets.dart';

class TeacherCard extends StatefulWidget {
  final Teacher? teacher;
  final IsarService isarService;
  const TeacherCard(
      {super.key, required this.teacher, required this.isarService});

  @override
  State<TeacherCard> createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheets.showBottomSheetAddTeacher(
            context, widget.isarService, widget.teacher);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 20, right: 15, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8.0)),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                if (widget.teacher != null) {
                  widget.isarService.deleteTeacher(widget.teacher!);
                }
              });
            },
          ),
          title: Text(
            widget.teacher?.name ?? '--:--',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text('Course: ${widget.teacher?.course.value?.title}',
              style: GoogleFonts.dmSans(
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w400))),
        ),
      ),
    );
  }
}
