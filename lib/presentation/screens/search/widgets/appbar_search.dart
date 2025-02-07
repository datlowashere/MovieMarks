import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_edit_text.dart';

class AppbarSearch extends StatefulWidget {
  final VoidCallback? onTapBack, onTapSearch;
  final String searchValue;
  final ValueChanged onChangeSearch;

  const AppbarSearch(
      {super.key,
      this.onTapBack,
      this.onTapSearch,
      required this.searchValue,
      required this.onChangeSearch});

  @override
  State<AppbarSearch> createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29).copyWith(top: 8),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Row(
          children: [
            CustomButton(
              prefix: SvgPicture.asset(AppIcons.arrowBack.svgAssetPath),
              onTap: widget.onTapBack,
              backgroundColor: Colors.transparent,
            ),
            Expanded(
                child: CustomEditText(
              backgroundColor: AppColors.charlestonGreen,
              hintText: AppConstants.search,
              initialValue: widget.searchValue,
              onChanged: widget.onChangeSearch,
            )),
            const SizedBox(width: 29,),
          ],
        ),
      ),
    );
  }
}
