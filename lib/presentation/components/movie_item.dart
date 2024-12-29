import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_images.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/movie_model.dart';

import '../../config/theme/app_icons.dart';
import 'custom_text_pair.dart';

class MovieItem extends StatelessWidget {
  final bool? isShowRating;
  final bool? isShowReadMore;
  final MovieModel? movieModel;
  final int? index;
  final VoidCallback? onTapMovie;
  final VoidCallback? onTapBookmark;

  const MovieItem({
    super.key,
    this.isShowRating,
    this.isShowReadMore,
    this.index,
    this.movieModel,
    this.onTapBookmark,
    this.onTapMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMovie,
      child: Container(
        color: AppColors.charlestonGreen,
        margin: EdgeInsets.only(top: index == 0 ? 0 : 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPosterImage(),
            Expanded(child: _buildMovieDetails()),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    return Container(
      width: 95,
      height: 120,
      margin: const EdgeInsets.only(right: 22),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          ApiUrls.imageUrl + (movieModel?.posterPath ?? ""),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AppImages.defaultAvatar.webpAssetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextPair(
          marginBottom: 5,
          betweenSpacing: 0,
          title: AppConstants.title,
          content: movieModel?.originalTitle ?? "",
        ),
        CustomTextPair(
          marginBottom: 5,
          betweenSpacing: 0,
          title: AppConstants.releaseDate,
          content: movieModel?.releaseDate ?? "",
        ),
        CustomTextPair(
          marginBottom: 5,
          betweenSpacing: 0,
          title: AppConstants.averageRating,
          content: movieModel?.voteAverage?.toString() ?? "",
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBookmarkButton(),
          const SizedBox(height: 18),
          if (isShowRating ?? true) _buildRatingWidget(),
          const SizedBox(height: 60),
          if (isShowReadMore ?? true)
            Text(
              AppConstants.readMore,
              textAlign: TextAlign.left,
              style: AppTextStyles.beVietNamProStyles.regular12Eucalyptus,
            ),
        ],
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        onPressed: onTapBookmark,
        icon: SvgPicture.asset(
          movieModel?.isSaved == true
              ? AppIcons.bookmarkFilled.svgAssetPath
              : AppIcons.bookmark.svgAssetPath,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildRatingWidget() {
    return Column(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              movieModel?.isRating == true
                  ? AppIcons.starFilled.svgAssetPath
                  : AppIcons.star.svgAssetPath,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            movieModel?.isRating == true ? "9.5" : "na",
            textAlign: TextAlign.center,
            style: AppTextStyles.beVietNamProStyles.regular12White.copyWith(
              color: movieModel?.isRating == true
                  ? AppColors.eucalyptus
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
