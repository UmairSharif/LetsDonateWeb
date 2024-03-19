import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_donate_web/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required String title,
    this.isLoading = false,
    required void Function()? onPressed,
  })  : _title = title,
        _onPressed = onPressed;

  final String _title;
  final bool isLoading;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.value,
            disabledBackgroundColor: AppColors.primary.value.withOpacity(0.5),
            shadowColor: Colors.black),
        onPressed: !isLoading ? _onPressed : null,
        child: Container(
          width: double.infinity,
          height: 55.0,
          alignment: Alignment.center,
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(
                  _title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
        ));
  }
}
