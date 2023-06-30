import 'package:flutter/material.dart';
import 'package:isar_learning/data/course.dart';

class TeacherProfileScreen extends StatefulWidget {
  final String title;
  final Course course;
  const TeacherProfileScreen(
      {super.key, required this.title, required this.course});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 120,
            width: 120,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(widget.course.teacher.value?.name ?? '--:--',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 25)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.course.students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.course.students.toList()[index].name),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
