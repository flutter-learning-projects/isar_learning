import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/data/course.dart';
import 'package:isar_learning/screens/teachers_screen.dart';
import 'package:isar_learning/service/isar_service.dart';
import 'package:isar_learning/widgets/bottom_view_buttons.dart';
import 'package:isar_learning/widgets/course_card.dart';
import 'package:isar_learning/widgets/custom_menu_item.dart';

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
          textTheme: TextTheme(
              titleMedium: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500, color: Colors.black),
              bodySmall:
                  GoogleFonts.dmSans(color: Colors.black, fontSize: 14))),
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
  IsarService isarService = IsarService();

  @override
  void initState() {
    isarService.getAllCourses().then((value) {
      setState(() {
        courses = value;
      });
    });
    streamSubscription = isarService.listenToCourse().listen((event) {
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
    SampleItem? selectedMenu;
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Isar Learning'),
          elevation: 0,
          actions: [dropDownButton(selectedMenu)],
        ),
        body: courses?.isNotEmpty == true
            ? ListView.builder(
                itemCount: courses?.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCard(course: courses![index]);
                })
            : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: BottomViewButtons(isarService: isarService),
      ),
    );
  }

  PopupMenuButton<SampleItem> dropDownButton(SampleItem? selectedMenu) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: CustomMenuItem(
              iconData: Icons.local_library_rounded,
              itemText: 'Courses',
              callback: () {}),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: CustomMenuItem(
              iconData: Icons.person,
              itemText: 'Teachers',
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeachersScreen()),
                );
              }),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: CustomMenuItem(
              iconData: Icons.person, itemText: 'Students', callback: () {}),
        ),
      ],
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }
