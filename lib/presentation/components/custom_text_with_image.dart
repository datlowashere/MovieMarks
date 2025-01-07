import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/presentation/components/custom_avatar.dart';

class CustomTextWithImage extends StatefulWidget {
  final String url;
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const CustomTextWithImage(
      {super.key,
      required this.url,
      required this.text,
      this.textStyle,
      this.textAlign});

  @override
  State<CustomTextWithImage> createState() => _CustomTextWithImageState();
}

class _CustomTextWithImageState extends State<CustomTextWithImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAvatar(url: widget.url, width: 40, height: 40, radius: 16),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.text,
          style: widget.textStyle ??
              AppTextStyles.beVietNamProStyles.medium12White,
          softWrap: true,
          textAlign: widget.textAlign ?? TextAlign.center,
        )
      ],
    );
  }
}
