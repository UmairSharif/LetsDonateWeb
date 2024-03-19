import 'package:flutter/material.dart';
import 'package:lets_donate_web/constants/app_colors.dart';
import 'package:lets_donate_web/common/text_field_container.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required String hint,
      required TextEditingController textController,
      required String icon,
      TextInputType inputType = TextInputType.text,
      this.onChange})
      : _hint = hint,
        _textController = textController,
        _icon = icon,
        _inputType = inputType;

  final String _hint;
  final TextEditingController _textController;
  final String _icon;
  final TextInputType _inputType;
  final void Function(String)? onChange;

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
              _icon,
              height: 24,
              width: 24,
              color: Colors.white,
            )),
        hintText: _hint);
    return TextFieldContainer(
      textField: TextFormField(
        style: textStyle,
        decoration: inputDecoration,
        controller: _textController,
        keyboardType: _inputType,
        onChanged: onChange,
      ),
    );
  }
}
