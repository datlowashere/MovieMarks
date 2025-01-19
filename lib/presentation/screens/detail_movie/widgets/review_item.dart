import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/presentation/components/custom_avatar.dart';

class ReviewItem extends StatefulWidget {
  final String? userUrl, username, review, createAt;
  final double? ratingPoint;

  const ReviewItem(
      {super.key,
      this.userUrl,
      this.username,
      this.review,
      this.ratingPoint,
      this.createAt});

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.arsenic,
        borderRadius: BorderRadius.circular(8),
      ),      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAvatar(
              url: widget.userUrl ?? "", width: 60, height: 60, radius: 16),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.username ?? "${widget.ratingPoint ?? 0}",
                        style: AppTextStyles.beVietNamProStyles.regular14White,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: widget.ratingPoint ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.review ?? "",
                  style: AppTextStyles.beVietNamProStyles.regular14White,
                  maxLines: null,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.createAt ?? "",
                      style: AppTextStyles.beVietNamProStyles.regular12White
                          .copyWith(fontStyle: FontStyle.italic),
                      maxLines: null,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
