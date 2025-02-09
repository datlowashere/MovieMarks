import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';

class BottomSheetCameraOption extends StatelessWidget {
  final VoidCallback? onTapCamera, onTapGallery;

  const BottomSheetCameraOption(
      {super.key, this.onTapCamera, this.onTapGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.arsenic,
      padding: const EdgeInsets.symmetric(horizontal: 29).copyWith(top: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTitle(
                title: AppConstants.option,
                style: AppTextStyles.beVietNamProStyles.bold16White,
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  AppIcons.close.svgAssetPath,
                  height: 16,
                  width: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          CustomButton(
            prefix: SvgPicture.asset(
              AppIcons.addCamera.svgAssetPath,
              width: 40,
            ),
            title: AppConstants.fromCamera,
            titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
            textMarginLeft: 12,
            backgroundColor: AppColors.arsenic,
            isFullWidth: true,
            isExpanded: true,
            onTap: onTapCamera,
          ),
          CustomButton(
            prefix: SvgPicture.asset(
              AppIcons.gallery.svgAssetPath,
              width: 40,
            ),
            title: AppConstants.fromGallery,
            titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
            textMarginLeft: 12,
            backgroundColor: AppColors.arsenic,
            isFullWidth: true,
            isExpanded: true,
            onTap: onTapGallery,
          ),
          const SizedBox(height: 29,)
        ],
      ),
    );
  }
}
