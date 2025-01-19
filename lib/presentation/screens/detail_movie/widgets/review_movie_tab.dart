import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/review_data_model.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/review_item.dart';
import 'package:movie_marks/utils/date_format_helper.dart';

class ReviewMovieTab extends StatefulWidget {
  final ReviewDataModel reviewData;
  final VoidCallback onTapWriteReview;

  const ReviewMovieTab(
      {super.key, required this.reviewData, required this.onTapWriteReview});

  @override
  State<ReviewMovieTab> createState() => _ReviewMovieTabState();
}

class _ReviewMovieTabState extends State<ReviewMovieTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitle(
          title: widget.reviewData.averageRating,
          isFullWidth: true,
          style: AppTextStyles.beVietNamProStyles.semiBold18White,
          padding: const EdgeInsets.only(left: 8),
        ),
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: RatingBar.builder(
                  initialRating:
                      double.parse(widget.reviewData.averageRating),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20.0,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (double value) {},
                ),
              ),
            ),
            CustomTitle(
              title: "(${widget.reviewData.reviews.length})",
              style: AppTextStyles.beVietNamProStyles.semiBold14White,
              padding: const EdgeInsets.only(left: 8),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        CustomButton(
          title: AppConstants.writeAReview,
          isFullWidth: true,
          backgroundColor: AppColors.arsenic,
          titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: widget.onTapWriteReview,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTitle(
          title: AppConstants.reviews,
          style: AppTextStyles.beVietNamProStyles.medium12White,
          isFullWidth: true,
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final review = widget.reviewData.reviews[index];
              return ReviewItem(
                userUrl: review.user?.avatar,
                username: review.user?.username,
                review: review.content,
                ratingPoint: review.ratingPoint?.toDouble(),
                createAt: review.createdAt != null
                    ? DateFormatHelper.formatDate(review.createdAt)
                    : "",
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: widget.reviewData.reviews.length),
        const SizedBox(height: 29),
      ],
    );
  }
}
