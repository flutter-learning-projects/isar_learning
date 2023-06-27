import 'package:flutter/material.dart';
import 'package:isar_learning/data/course.dart';

class CustomMultiSelection extends StatefulWidget {
  const CustomMultiSelection({
    super.key,
    required this.courses,
  });

  final List<Course>? courses;

  @override
  State<CustomMultiSelection> createState() => _CustomMultiSelectionState();
}

class _CustomMultiSelectionState extends State<CustomMultiSelection> {
  List<bool>? checkedItems;

  // = List<bool>.generate(widget.courses!.length, (index) => false);

  @override
  void initState() {
    checkedItems =
        List<bool>.generate(widget.courses?.length ?? 0, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Courses'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.blue.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return Colors.blue.withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
        TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blue.withOpacity(0.04);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return Colors.blue.withOpacity(0.12);
                  }
                  return null; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'))
      ],
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.courses?.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(widget.courses?[index].title ?? '--:--'),
                        value: checkedItems?[index],
                        onChanged: (value) {
                          setState(() {
                            checkedItems?[index] =
                                !(checkedItems?[index] == true);
                          });
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
