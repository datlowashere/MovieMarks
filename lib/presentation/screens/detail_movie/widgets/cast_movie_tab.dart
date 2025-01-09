import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/cast_model.dart';
import 'package:movie_marks/data/models/movie_credits_model.dart';
import 'package:movie_marks/presentation/components/custom_text_with_image.dart';

class CastMovieTab extends StatelessWidget {
  final MovieCreditsModel movieCreditsModel;

  const CastMovieTab({super.key, required this.movieCreditsModel});

  @override
  Widget build(BuildContext context) {
    final firstOrderCasts =
        movieCreditsModel.cast.where((cast) => cast.order <= 3).toList();
    final remainingCasts =
        movieCreditsModel.cast.where((cast) => cast.order > 3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        _buildSectionTitle(AppConstants.mainCasts),
        _buildCastGrid(firstOrderCasts),
        remainingCasts.isNotEmpty
            ? _buildSectionTitle(AppConstants.otherCasts)
            : const SizedBox.shrink(),
        _buildCastGrid(remainingCasts),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: AppTextStyles.beVietNamProStyles.medium12White,
      ),
    );
  }

  Widget _buildCastGrid(List<CastModel> casts) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: casts.length,
      itemBuilder: (context, index) {
        final cast = casts[index];
        return CustomTextWithImage(
          avatarHeight: 60,
          avatarWidth: 60,
          imageUrl: ApiUrls.imageUrl + (cast.profilePath),
          title: cast.name,
          content: cast.character,
        );
      },
    );
  }
}
