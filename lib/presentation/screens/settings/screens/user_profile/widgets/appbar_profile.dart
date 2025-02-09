import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';

class AppbarProfile extends StatelessWidget {
  final VoidCallback? onTapBack;

  const AppbarProfile({super.key, this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Row(
        children: [
          CustomButton(
            prefix: SvgPicture.asset(AppIcons.arrowBack.svgAssetPath),
            onTap: onTapBack,
            backgroundColor: Colors.transparent,
          ),
          Expanded(
              child: CustomTitle(
            title: AppConstants.profile,
            style: AppTextStyles.beVietNamProStyles.bold16White,
          )),
          const SizedBox(
            width: 29,
          ),
        ],
      ),
    );
  }
}
