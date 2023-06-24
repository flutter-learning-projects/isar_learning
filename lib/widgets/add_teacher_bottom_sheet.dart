import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTeacherBottomSheet extends StatelessWidget {
  const AddTeacherBottomSheet({
    super.key,
    required this.controllerAddCourse,
  });

  final TextEditingController controllerAddCourse;

  @override
  Widget build(BuildContext context) {
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
  }
}
