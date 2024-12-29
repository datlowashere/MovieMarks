import 'package:flutter/cupertino.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';


class CustomTextPair extends StatelessWidget {
  final String title, content;
  final double betweenSpacing, marginBottom;

  const CustomTextPair({super.key,
    required this.title,
    required this.content,
    this.betweenSpacing = 12,
    this.marginBottom = 12});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.beVietNamProStyles.medium12White,
        ),
        SizedBox(height: betweenSpacing),
        Text(
          content,
          style: AppTextStyles.beVietNamProStyles.regular12White,
        ),
        SizedBox(height: marginBottom,)
      ],
    );
  }
}
