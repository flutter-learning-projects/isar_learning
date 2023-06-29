import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/screens/teacher_screen.dart';
import 'package:isar_learning/service/isar_service.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TeacherScreen(
                    title: 'Teacher',
                    course: course,
                  )),
        );
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
              IsarService();
            },
          ),
          title: Text(
            course.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text('Students: ${course.students.length}',
              style: GoogleFonts.dmSans(
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w400))),
        ),
      ),
    );
  }
}
