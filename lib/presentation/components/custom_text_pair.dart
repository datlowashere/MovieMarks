import 'package:flutter/cupertino.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class CustomTextPair extends StatelessWidget {
  final String title, content;
  final double betweenSpacing, marginBottom;
  final TextStyle? titleStyle, contentStyle;
  final Color? titleColor, contentColor;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomTextPair(
      {super.key,
      required this.title,
      required this.content,
      this.betweenSpacing = 12,
      this.marginBottom = 12,
      this.titleStyle,
      this.contentStyle,
      this.titleColor,
      this.contentColor,
      this.crossAxisAlignment,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              AppTextStyles.beVietNamProStyles.medium14White
                  .copyWith(color: titleColor),
        ),
        SizedBox(height: betweenSpacing),
        Text(
          content,
          style: contentStyle ??
              AppTextStyles.beVietNamProStyles.regular14White
                  .copyWith(color: contentColor),
        ),
        SizedBox(height: marginBottom),
      ],
    );
  }
}
