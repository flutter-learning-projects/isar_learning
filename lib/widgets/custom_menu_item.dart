import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final IconData iconData;
  final String itemText;
  final VoidCallback callback;
  const CustomMenuItem(
      {super.key,
      required this.iconData,
      required this.itemText,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        callback.call();
      },
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.green,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(itemText)
        ],
      ),
    );
  }
}
