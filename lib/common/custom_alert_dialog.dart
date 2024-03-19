import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? okayPressed;

  const CustomAlertDialog(
      {super.key,
      this.title = 'Error',
      required this.message,
      this.okayPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (okayPressed != null) {
              okayPressed!();
            }
          },
          child: const Text("Okay"),
        )
      ],
    );
  }
}
