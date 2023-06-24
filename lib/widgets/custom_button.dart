import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const CustomButton(
      {super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ElevatedButton(
          onPressed: () {
            onTap.call();
          },
          style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              backgroundColor: Colors.greenAccent.shade700),
          child: Text(buttonText,
              style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleSmall)
                  .copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
