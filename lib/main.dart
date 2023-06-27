import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/bottom_view_buttons.dart';
import 'package:isar_learning/widgets/course_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BottomSheetTestPage(),
    );
  }
}

class BottomSheetTestPage extends StatefulWidget {
  const BottomSheetTestPage({super.key});

  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetTestPage> {
  List<Course>? courses;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    IsarService isar = IsarService();
    isar.getAllCourses().then((value) {
      setState(() {
        courses = value;
      });
    });

    streamSubscription = isar.listenToCourse().listen((event) {
      setState(() {
        courses = event;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('bottom sheet'),
        ),
        body: courses?.isNotEmpty == true
            ? ListView.builder(
                itemCount: courses?.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCard(title: courses?[index].title ?? '--:--');
                })
            : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: const BottomViewButtons(),
      ),
    );
  }
}
