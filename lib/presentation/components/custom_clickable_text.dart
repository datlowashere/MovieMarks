import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class CustomClickableText extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final VoidCallback? onTapSub;

  const CustomClickableText(
      {super.key,
      this.title,
      this.subTitle,
      this.titleStyle,
      this.subTitleStyle,
      this.onTapSub});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title ?? "",
          style: titleStyle ?? AppTextStyles.beVietNamProStyles.regular14White,
        ),
        GestureDetector(
          onTap: onTapSub,
          child: Text(
            subTitle ?? "",
            style: subTitleStyle ??
                AppTextStyles.beVietNamProStyles.regular14White,
          ),
        )
      ],
    );
  }
}
