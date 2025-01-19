import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';

import 'custom_button.dart';
import 'custom_title.dart';

class DialogLoginRequest extends StatefulWidget {
  const DialogLoginRequest({
    super.key,
  });

  @override
  State<DialogLoginRequest> createState() => _DialogLoginRequestState();
}

class _DialogLoginRequestState extends State<DialogLoginRequest> {
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
                    title: AppConstants.alert,
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
              title: AppConstants.haveToLogin,
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
                    titleStyle:
                        AppTextStyles.beVietNamProStyles.semiBold14White,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    isFullWidth: true,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    title: AppConstants.goToLogin,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    backgroundColor: AppColors.eucalyptus,
                    titleStyle:
                        AppTextStyles.beVietNamProStyles.semiBold14White,
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
