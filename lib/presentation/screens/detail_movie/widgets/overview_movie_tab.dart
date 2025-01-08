import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/external_ids_model.dart';
import 'package:movie_marks/data/models/keyword_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_text_pair.dart';
import 'package:movie_marks/presentation/components/custom_text_with_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/theme/app_text_styles.dart';

class OverviewMovieTab extends StatefulWidget {
  final MovieModel movieModel;
  final List<KeywordModel> keywords;
  final ExternalIdsModel externalIdsModel;

  const OverviewMovieTab({
    super.key,
    required this.movieModel,
    required this.keywords,
    required this.externalIdsModel,
  });

  @override
  State<OverviewMovieTab> createState() => _OverviewMovieTabState();
}

class _OverviewMovieTabState extends State<OverviewMovieTab> {
  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          _buildOverviewSection(),
          const SizedBox(height: 10),
          _buildMovieDetailsGrid(widget.movieModel),
          const SizedBox(height: 10),
          _buildProductionCountriesSection(),
          const SizedBox(height: 10),
          _buildProductionCompaniesSection(),
          const SizedBox(height: 10),
          _buildSocialLinksSection(),
          const SizedBox(height: 10),
          _buildKeywordsSection(),
          const SizedBox(height: 29),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return CustomTextPair(
      title: AppConstants.overViews,
      content: widget.movieModel.overview ?? "",
      betweenSpacing: 5,
    );
  }

  Widget _buildProductionCountriesSection() {
    final title = (widget.movieModel.productionCountries?.length ?? 0) > 1
        ? AppConstants.productionCountries
        : AppConstants.productionCountry;

    final content = widget.movieModel.productionCountries
            ?.map((country) => country.name)
            .join(', ') ??
        AppConstants.unKnow;

    return CustomTextPair(
      title: title,
      content: content,
      betweenSpacing: 5,
    );
  }

  Widget _buildProductionCompaniesSection() {
    final title = (widget.movieModel.productionCompanies?.length ?? 0) > 1
        ? AppConstants.productionCompanies
        : AppConstants.productionCompany;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.beVietNamProStyles.medium12White,
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: (widget.movieModel.productionCompanies ?? []).map((item) {
            return CustomTextWithImage(
              avatarHeight: 60,
              avatarWidth: 60,
              imageUrl: ApiUrls.imageUrl + (item.logoPath ?? ""),
              title: item.name ?? "",
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.socialNetwork,
          style: AppTextStyles.beVietNamProStyles.medium12White,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconButton(
              onPressed: () => _launchUrl(
                  "${ApiUrls.facebookBaseUrl}${widget.externalIdsModel.facebookId}"),
              icon: SvgPicture.asset(
                AppIcons.facebook.svgAssetPath,
                width: 32,
              ),
            ),
            IconButton(
              onPressed: () => _launchUrl(
                  "${ApiUrls.xBaseUrl}${widget.externalIdsModel.twitterId}"),
              icon: SvgPicture.asset(
                AppIcons.x.svgAssetPath,
                width: 32,
              ),
            ),
            IconButton(
              onPressed: () => _launchUrl(
                  "${ApiUrls.instagramBaseUrl}${widget.externalIdsModel.instagramId}"),
              icon: SvgPicture.asset(
                AppIcons.instagram.svgAssetPath,
                width: 32,
              ),
            ),
            Container(
              height: 32,
              width: 1,
              color: AppColors.brightGray,
            ),
            IconButton(
                onPressed: () => _launchUrl(widget.movieModel.homepage),
                icon: SvgPicture.asset(
                  AppIcons.link.svgAssetPath,
                  width: 32,
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildKeywordsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.keywords,
          style: AppTextStyles.beVietNamProStyles.medium12White,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.keywords.map((item) {
            return CustomButton(
              onTap: () {},
              title: item.name ?? AppConstants.unKnow,
              backgroundColor: AppColors.arsenic,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMovieDetailsGrid(MovieModel movieModel) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CustomTextPair(
          title: AppConstants.originalTitle,
          content: movieModel.originalTitle ?? "N/A",
          betweenSpacing: 5,
        ),
        CustomTextPair(
          title: AppConstants.originalLanguage,
          content: movieModel.spokenLanguages?.isNotEmpty == true
              ? movieModel.spokenLanguages![0].englishName ?? "N/A"
              : "N/A",
          betweenSpacing: 5,
        ),
        CustomTextPair(
          title: AppConstants.releaseDate,
          content: movieModel.releaseDate ?? "N/A",
          betweenSpacing: 5,
        ),
        CustomTextPair(
          title: AppConstants.averageRating,
          content: movieModel.voteAverage.toString(),
          betweenSpacing: 5,
        ),
        CustomTextPair(
          title: AppConstants.rateCount,
          content: movieModel.voteCount.toString(),
          betweenSpacing: 5,
        ),
        CustomTextPair(
          title: AppConstants.popularity,
          content: movieModel.popularity.toString(),
          betweenSpacing: 5,
        ),
      ],
    );
  }
}
