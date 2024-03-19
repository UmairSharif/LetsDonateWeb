import 'package:flutter/material.dart';
import 'package:lets_donate_web/constants/app_colors.dart';
import 'package:lets_donate_web/common/text_field_container.dart';

class SecureTextField extends StatefulWidget {
  const SecureTextField({
    super.key,
    String hint = "Enter your password",
    required TextEditingController passwordController,
    required String icon,
  })  : _hint = hint,
        _passwordController = passwordController,
        _icon = icon;

  final String _hint;
  final TextEditingController _passwordController;
  final String _icon;

  @override
  State<SecureTextField> createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  bool _passwordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0);
    var inputDecoration = InputDecoration(
        hintStyle: textStyle,
        border: InputBorder.none,
        icon: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: AppColors.primary.value, shape: BoxShape.circle),
          child: Image.asset(
            widget._icon,
            height: 24,
            width: 24,
          ),
        ),
        hintText: widget._hint,
        suffixIcon: IconButton(
            onPressed: _toggle,
            icon: Icon(
                _passwordVisible ? Icons.visibility_off : Icons.visibility)));

    return TextFieldContainer(
      textField: TextFormField(
        style: textStyle,
        decoration: inputDecoration,
        controller: widget._passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _passwordVisible,
        enableSuggestions: false,
        autocorrect: false,
      ),
    );
  }
}
