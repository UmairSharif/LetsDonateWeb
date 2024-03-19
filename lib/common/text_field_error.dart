import 'package:flutter/material.dart';

class TextFieldError extends StatelessWidget {
  const TextFieldError({
    super.key,
    required String? errorText,
  }) : _errorText = errorText;

  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 4),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          _errorText!,
          style: const TextStyle(color: Colors.red, fontSize: 12.0),
        ),
      ),
    );
  }
}
