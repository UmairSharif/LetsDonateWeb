import 'package:flutter/material.dart';
import 'package:lets_donate_web/constants/app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({super.key, required Widget textField})
      : _textField = textField;

  final Widget _textField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.value, width: 1.0),
          borderRadius: BorderRadius.circular(30.0)),
      child: _textField,
    );
  }
}
