import 'package:flutter/material.dart';

enum AppColors { primary }

extension AppColorsExtention on AppColors {
  Color get value {
    switch (this) {
      case AppColors.primary:
        return const Color(0xFF3DD47E);
    }
  }
}
