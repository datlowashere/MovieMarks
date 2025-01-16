import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(height: 1, color: AppColors.brightGray,)),
        const SizedBox(width: 12,),
        Text(AppConstants.or, style: AppTextStyles.beVietNamProStyles.regular14White,),
        const SizedBox(width: 12,),
        const Expanded(child: Divider(height: 1, color: AppColors.brightGray,)),
      ],
    );
  }
}