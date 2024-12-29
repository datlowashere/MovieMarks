import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';

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

  final regular16White =
      customBeVietNamProStyle(16, Colors.white, AppFontWeight.regular.weight);
  final regular16Black =
      customBeVietNamProStyle(16, Colors.black, AppFontWeight.regular.weight);
  final regular12White =
      customBeVietNamProStyle(12, Colors.white, AppFontWeight.regular.weight);
  final regular12Green = customBeVietNamProStyle(
      12, AppColors.mintGreen, AppFontWeight.regular.weight);
  final medium12White =
      customBeVietNamProStyle(12, Colors.white, AppFontWeight.medium.weight);
  final semiBold12White =
      customBeVietNamProStyle(12, Colors.white, AppFontWeight.semiBold.weight);
  final semiBold12Grey = customBeVietNamProStyle(
      12, AppColors.darkGrey, AppFontWeight.semiBold.weight);
  final regular14White =
      customBeVietNamProStyle(14, Colors.white, AppFontWeight.regular.weight);
  final semiBold14Grey = customBeVietNamProStyle(
      14, AppColors.darkGrey, AppFontWeight.semiBold.weight);
  final semiBold14Shade = customBeVietNamProStyle(
      14, AppColors.shadeGrey, AppFontWeight.semiBold.weight);
  final semiBold18White =
      customBeVietNamProStyle(18, Colors.white, AppFontWeight.semiBold.weight);
  final bold36White =
      customBeVietNamProStyle(36, Colors.white, AppFontWeight.bold.weight);
}
