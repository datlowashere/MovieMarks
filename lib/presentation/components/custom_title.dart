import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';

class CustomTitle extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final TextStyle? style;
  final double? width, height;
  final bool isFullWidth, isFullHeight;

  const CustomTitle(
      {super.key,
      this.title,
      this.margin,
      this.padding,
      this.textAlign,
      this.style,
      this.width,
      this.height,
      this.isFullWidth = false,
      this.isFullHeight = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: margin,
      padding: padding,
      width: isFullWidth ? screenWidth : width,
      height: isFullHeight ? screenHeight : height,
      child: Text(
        title ?? AppConstants.title,
        textAlign: textAlign ?? TextAlign.left,
        style: style ?? AppTextStyles.beVietNamProStyles.semiBold16White,
      ),
    );
  }
}
