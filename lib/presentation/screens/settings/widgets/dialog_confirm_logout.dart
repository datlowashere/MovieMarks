import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';

class DialogConfirmLogout extends StatefulWidget {
  final VoidCallback onTapYes;

  const DialogConfirmLogout({super.key, required this.onTapYes});

  @override
  State<DialogConfirmLogout> createState() => _DialogConfirmLogoutState();
}

class _DialogConfirmLogoutState extends State<DialogConfirmLogout> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.charlestonGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTitle(
                    title: AppConstants.confirmation,
                    style: AppTextStyles.beVietNamProStyles.semiBold18White,
                  ),
                ),
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
              height: 6,
            ),
            CustomTitle(
              title: AppConstants.wantToLogout,
              style: AppTextStyles.beVietNamProStyles.regular14White,
            ),
            const SizedBox(
              height: 34,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomButton(
                    title: AppConstants.no,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    backgroundColor: AppColors.charlestonGreen,
                    titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    isFullWidth: true,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    title: AppConstants.yes,
                    onTap: widget.onTapYes,
                    backgroundColor: AppColors.eucalyptus,
                    titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
