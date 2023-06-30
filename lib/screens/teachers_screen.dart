import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar_learning/data/teacher.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/teacher_card.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  List<Teacher>? teachers;
  StreamSubscription? streamSubscription;
  IsarService isarService = IsarService();

  @override
  void initState() {
    isarService.getAllTeachers().then((value) {
      setState(() {
        teachers = value;
      });
    });
    streamSubscription = isarService.listenToTeacher().listen((event) {
      setState(() {
        teachers = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Teachers'),
        elevation: 0,
      ),
      body: teachers?.isNotEmpty == true
          ? ListView.builder(
              itemCount: teachers?.length,
              itemBuilder: (context, index) {
                return TeacherCard(
                  teacher: teachers?[index],
                  isarService: isarService,
                );
              })
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
