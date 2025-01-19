import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_text_area.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';

class BottomSheetWriteReview extends StatefulWidget {
  final Function(double) onRatingUpdate;
  final ValueChanged<String> onChanged;
  final VoidCallback onTapSubmit;

  const BottomSheetWriteReview(
      {super.key,
      required this.onRatingUpdate,
      required this.onChanged,
      required this.onTapSubmit});

  @override
  State<BottomSheetWriteReview> createState() => _BottomSheetWriteReviewState();
}

class _BottomSheetWriteReviewState extends State<BottomSheetWriteReview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        color: AppColors.charlestonGreen,
        padding: const EdgeInsets.symmetric(horizontal: 29),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                CustomTitle(
                  title: AppConstants.writeAReview,
                  style: AppTextStyles.beVietNamProStyles.semiBold14White,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                const SizedBox(
                  height: 12,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (double value) {
                    widget.onRatingUpdate(value);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextArea(
                  cursorColor: AppColors.brightGray,
                  backgroundColor: AppColors.arsenic,
                  borderColor: Colors.transparent,
                  textInputType: TextInputType.multiline,
                  onChanged: widget.onChanged,
                  maxLines: null,
                  height: 200,
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    title: AppConstants.submit,
                    backgroundColor: AppColors.arsenic,
                    titleStyle: AppTextStyles.beVietNamProStyles.bold16White,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: widget.onTapSubmit,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
