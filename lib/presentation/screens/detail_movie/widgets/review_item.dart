import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/presentation/components/custom_avatar.dart';

class ReviewItem extends StatefulWidget {
  final String? userUrl, username, review;
  final int? averagePoint;

  const ReviewItem(
      {super.key, this.userUrl, this.username, this.review, this.averagePoint});

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAvatar(
            url: widget.userUrl ?? "", width: 40, height: 40, radius: 16),
        const SizedBox(
          width: 12,
        ),
        Column(
          children: [
            Text(
              widget.username ?? "",
              style: AppTextStyles.beVietNamProStyles.regular12White,
            ),
            Text(
              widget.review ?? "",
              style: AppTextStyles.beVietNamProStyles.regular12White,
              maxLines: null,
            )
          ],
        ),
        Text(
          widget.averagePoint.toString(),
          style: AppTextStyles.beVietNamProStyles.regular12White,
        ),
      ],
    );
  }
}
