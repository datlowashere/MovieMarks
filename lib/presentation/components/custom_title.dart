import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';

class CustomTitle extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final TextStyle? style;

  const CustomTitle({
    super.key,
    this.title,
    this.margin,
    this.padding,
    this.textAlign,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Text(
        title ?? AppConstants.title,
        textAlign: textAlign ?? TextAlign.left,
        style: style ?? AppTextStyles.beVietNamProStyles.semiBold14Black,
      ),
    );
  }
}
