import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_text_pair.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';

class AppBarHome extends StatefulWidget {
  final VoidCallback? onTapSearch;
  final UserModel? userModel;

  const AppBarHome({super.key, this.onTapSearch, this.userModel});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 29),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: AppConstants.appName,
                style: AppTextStyles.beVietNamProStyles.bold36White,
              ),
              // CustomAvatar(url: "", width: 40, height: 40, radius: 16),
              CustomButton(
                title: '',
                onTap: widget.onTapSearch,
                borderRadius: 16,
                prefix: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              )
            ],
          ),
          Row(
            children: [
              CustomTextPair(
                title: AppConstants.welcomeBack,
                content: widget.userModel?.username ?? "",
                titleStyle: AppTextStyles.beVietNamProStyles.semiBold14BrightGray,
                contentStyle:
                    AppTextStyles.beVietNamProStyles.semiBold14BrightGray,
                mainAxisAlignment: MainAxisAlignment.center,
                betweenSpacing: 0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
