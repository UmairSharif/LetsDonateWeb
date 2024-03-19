import 'package:flutter/material.dart';
import 'package:lets_donate_web/common/app_text_field.dart';
import 'package:lets_donate_web/common/text_field_error.dart';

class TextInputWidget extends StatelessWidget {
  final String hint;
  final TextEditingController textController;
  final String icon;
  final TextInputType inputType;
  final String? errorText;

  const TextInputWidget({
    super.key,
    required this.hint,
    required this.textController,
    required this.icon,
    this.inputType = TextInputType.text,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AppTextField(
            hint: hint,
            textController: textController,
            icon: icon,
            inputType: inputType,
          ),
          if (errorText != null) TextFieldError(errorText: errorText!),
        ],
      ),
    );
  }
}
