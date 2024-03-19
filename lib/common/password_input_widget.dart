import 'package:flutter/material.dart';
import 'package:lets_donate_web/common/secure_text_field.dart';
import 'package:lets_donate_web/common/text_field_error.dart';

class PasswordInputWidget extends StatelessWidget {
  final String hint;
  final TextEditingController passwordController;
  final String icon;
  final String? errorText;

  const PasswordInputWidget({
    super.key,
    required this.hint,
    required this.passwordController,
    required this.icon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SecureTextField(
            hint: hint,
            passwordController: passwordController,
            icon: icon,
          ),
          if (errorText != null) TextFieldError(errorText: errorText!),
        ],
      ),
    );
  }
}
