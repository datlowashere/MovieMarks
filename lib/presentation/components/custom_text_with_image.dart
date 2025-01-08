import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/presentation/components/custom_avatar.dart';

class CustomTextWithImage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String? content;
  final TextStyle? titleStyle, contentStyle;
  final TextAlign? titleAlign, contentAlign;
  final double? avatarWidth, avatarHeight, avatarRadius;

  const CustomTextWithImage({
    super.key,
    required this.imageUrl,
    required this.title,
    this.content,
    this.titleStyle,
    this.contentStyle,
    this.titleAlign,
    this.contentAlign,
    this.avatarWidth,
    this.avatarHeight,
    this.avatarRadius,
  });

  @override
  State<CustomTextWithImage> createState() => _CustomTextWithImageState();
}

class _CustomTextWithImageState extends State<CustomTextWithImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAvatar(
          url: widget.imageUrl,
          width: widget.avatarWidth ?? 40,
          height: widget.avatarHeight ?? 40,
          radius: widget.avatarRadius ?? 16,
        ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: widget.titleStyle ??
              AppTextStyles.beVietNamProStyles.medium12White,
          softWrap: true,
          textAlign: widget.titleAlign ?? TextAlign.center,
        ),
        if (widget.content != null && widget.content!.isNotEmpty)
          Text(
            widget.content!,
            style: widget.contentStyle ??
                AppTextStyles.beVietNamProStyles.medium12White,
            softWrap: true,
            textAlign: widget.contentAlign ?? TextAlign.center,
          ),
      ],
    );
  }
}
