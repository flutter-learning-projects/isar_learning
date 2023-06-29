import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('bottom sheet'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon:
                  Icon(Platform.isAndroid ? Icons.more_vert : Icons.more_horiz),
            )
          ],
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
}

// class CustomButtonTest extends StatefulWidget {
//   const CustomButtonTest({Key? key}) : super(key: key);

//   @override
//   State<CustomButtonTest> createState() => _CustomButtonTestState();
// }

// class _CustomButtonTestState extends State<CustomButtonTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             customButton: const Icon(
//               Icons.list,
//               size: 46,
//               color: Colors.red,
//             ),
//             customItemsIndexes: const [3],
//             customItemsHeight: 8,
//             items: [
//               ...MenuItems.firstItems.map(
//                 (item) => DropdownMenuItem<MenuItem>(
//                   value: item,
//                   child: MenuItems.buildItem(item),
//                 ),
//               ),
//               const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
//               ...MenuItems.secondItems.map(
//                 (item) => DropdownMenuItem<MenuItem>(
//                   value: item,
//                   child: MenuItems.buildItem(item),
//                 ),
//               ),
//             ],
//             onChanged: (value) {
//               MenuItems.onChanged(context, value as MenuItem);
//             },
//             itemHeight: 48,
//             itemWidth: 160,
//             itemPadding: const EdgeInsets.only(left: 16, right: 16),
//             dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               color: Colors.redAccent,
//             ),
//             dropdownElevation: 8,
//             offset: const Offset(0, 8),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, students, teachers];
  static const List<MenuItem> secondItems = [logout];

  static const home =
      MenuItem(text: 'Courses', icon: Icons.auto_stories_rounded);
  static const teachers = MenuItem(text: 'Teachers', icon: Icons.person);
  static const students = MenuItem(text: 'Students', icon: Icons.person);
  static const logout = MenuItem(text: 'Exit', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.teachers:
        //Do something
        break;
      case MenuItems.students:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
