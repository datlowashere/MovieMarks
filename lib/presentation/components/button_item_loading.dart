import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ButtonItemLoading extends StatelessWidget {
  const ButtonItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.charlestonGreen,
      child: _buildShimmerBox(
          width: 95, height: 120, borderRadius: 16),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Shimmer.fromColors(
        baseColor: AppColors.arsenic,
        highlightColor: AppColors.brightGray,
        child: Container(
          width: width,
          height: height,
          color: AppColors.brightGray,
        ),
      ),
    );
  }
}
