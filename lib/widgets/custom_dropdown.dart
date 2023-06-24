import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_learning/service/isar_service.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropdownValue;
  List<String>? spinnerItems;
  IsarService isarService = IsarService();

  @override
  void initState() {
    isarService.getAllCourses().then((value) {
      setState(() {
        spinnerItems = value.map((e) => e.title).toList();
        dropdownValue = spinnerItems?[0];
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
      child: dropdownValue == null
          ? const CircularProgressIndicator()
          : DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
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
                onChanged: (String? data) {
                  setState(() {
                    dropdownValue = data;
                  });
                },
                items:
                    spinnerItems?.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
