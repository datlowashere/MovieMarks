import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class MovieItemLoading extends StatelessWidget {
  final bool isShowReadMore;

  const MovieItemLoading({super.key, this.isShowReadMore = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.charlestonGreen,
      margin: const EdgeInsets.only(top: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(width: 95, height: 120, borderRadius: 16),
          const SizedBox(width: 22),
          Expanded(child: _buildMovieDetailsPlaceholder()),
          _buildActionsPlaceholder(isShowReadMore),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(
      {required double width,
      required double height,
      double borderRadius = 8}) {
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

  Widget _buildMovieDetailsPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerBox(width: 120, height: 16),
        const SizedBox(height: 5),
        _buildShimmerBox(width: 80, height: 12),
        const SizedBox(height: 10),
        _buildShimmerBox(width: 100, height: 12),
        const SizedBox(height: 5),
        _buildShimmerBox(width: 100, height: 12),
        const SizedBox(height: 10),
        _buildShimmerBox(width: 100, height: 12),
        const SizedBox(height: 5),
        _buildShimmerBox(width: 100, height: 12),
      ],
    );
  }

  Widget _buildActionsPlaceholder(bool isShowReadMore) {
    return Padding(
      padding: const EdgeInsets.only(right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildShimmerBox(width: 24, height: 24),
          const SizedBox(height: 18),
          _buildShimmerBox(width: 24, height: 24),
          const SizedBox(height: 6),
          _buildShimmerBox(width: 24, height: 10),
          const SizedBox(height: 60),
          if (isShowReadMore) _buildShimmerBox(width: 60, height: 12),
        ],
      ),
    );
  }
}
