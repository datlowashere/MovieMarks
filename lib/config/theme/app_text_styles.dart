import 'package:flutter/material.dart';

enum AppFontFamily { beVietNamPro }

enum AppFontWeight { regular, medium, semiBold, bold }

extension AppFontFamilyDefault on AppFontFamily {
  String get name {
    switch (this) {
      case AppFontFamily.beVietNamPro:
        return 'BeVietNamPro';
    }
  }
}

extension BeVietNamProFontWeight on AppFontWeight {
  FontWeight get weight {
    switch (this) {
      case AppFontWeight.regular:
        return FontWeight.w400;
      case AppFontWeight.medium:
        return FontWeight.w500;
      case AppFontWeight.semiBold:
        return FontWeight.w600;
      case AppFontWeight.bold:
        return FontWeight.w700;
    }
  }
}

class AppTextStyles {
  const AppTextStyles._();

  static BeVietNamProStyles beVietNamProStyles = BeVietNamProStyles();
}

class BeVietNamProStyles {
  static TextStyle customBeVietNamProStyle(
    double size,
    Color color,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: AppFontFamily.beVietNamPro.name,
      color: color,
      fontWeight: fontWeight,
      fontSize: size,
    );
  }

  final regular16Tiffany =
      customBeVietNamProStyle(16, Colors.white, AppFontWeight.regular.weight);
}
