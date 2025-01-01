import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_images.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';

class AppBarDetailMovie extends StatelessWidget {
  final VoidCallback? onTapBack, onTapBookMark;
  final MovieModel movieModel;

  const AppBarDetailMovie({
    super.key,
    this.onTapBack,
    this.onTapBookMark,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.charlestonGreen,
      leading: CustomButton(
        prefix: SvgPicture.asset(AppIcons.arrowBack.svgAssetPath),
        onTap: onTapBack,
        backgroundColor: Colors.transparent,
      ),
      actions: [
        CustomButton(
          prefix: SvgPicture.asset(AppIcons.bookmark.svgAssetPath),
          onTap: onTapBookMark,
          backgroundColor: Colors.transparent,
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double collapsedHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final bool isCollapsed = constraints.maxHeight <= collapsedHeight;

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Opacity(
              opacity: isCollapsed ? 1.0 : 0.0,
              child: Text(
                movieModel.originalTitle ?? '',
                style: AppTextStyles.beVietNamProStyles.semiBold18White,
              ),
            ),
            background: Stack(
              alignment: Alignment.center,
              children: [
                _buildBackgroundImage(),
                _buildMovieInfo(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      bottom: 60,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Image.network(
          ApiUrls.imageUrl + (movieModel.backdropPath ?? ""),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AppImages.defaultPicker.pngAssetPath,
            fit: BoxFit.cover,
          ),
        )
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Positioned(
      bottom: 0,
      left: 29,
      right: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPosterImage(),
          const SizedBox(width: 22),
          Expanded(
            child: Text(
              movieModel.originalTitle ?? '',
              style: AppTextStyles.beVietNamProStyles.semiBold18White,
            ),
          ),
          const SizedBox(width: 29),
        ],
      ),
    );
  }

  Widget _buildPosterImage() {
    return Container(
      width: 95,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          ApiUrls.imageUrl + (movieModel.posterPath ?? ""),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AppImages.defaultPicker.pngAssetPath,
            fit: BoxFit.cover,
          ),
        )
      ),
    );
  }
}
