import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/presentation/components/custom_avatar.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_event.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_state.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/page/user_profile_page.dart';
import 'package:movie_marks/presentation/screens/settings/widgets/dialog_confirm_logout.dart';
import 'package:movie_marks/presentation/screens/settings/widgets/menu_option.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        state.status == SettingStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();

        if (state.status == SettingStatus.success) {
          Fluttertoast.showToast(
            msg: AppConstants.logoutSuccess,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  CustomTitle(
                    padding: const EdgeInsets.only(left: 29),
                    title: AppConstants.settings,
                    style: AppTextStyles.beVietNamProStyles.semiBold18White,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: 18),
                  _buildProfileSection(context, state),
                  const SizedBox(height: 24),
                  ..._buildMenuOptions(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, SettingState state) {
    return CustomButton(
      prefix: CustomAvatar(
        url: state.user?.avatar ?? "",
        width: 60,
        height: 60,
        radius: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 8),
      backgroundColor: AppColors.arsenic,
      isExpanded: true,
      title: state.user?.fullName?.isEmpty ?? true
          ? state.user?.username ?? ""
          : state.user?.fullName ?? "",
      subTitle: state.user?.email ?? "",
      subTitleStyle: AppTextStyles.beVietNamProStyles.regular12White,
      titleAlign: TextAlign.start,
      titleStyle: AppTextStyles.beVietNamProStyles.semiBold14White,
      subAlign: TextAlign.start,
      btnMainAxisAlignment: MainAxisAlignment.start,
      textMarginLeft: 12,
      borderRadius: 0,
      isFullWidth: true,
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfilePage()),
        );

        if (result == true) {
          context.read<SettingBloc>().add(SettingGetUserProfileEvent());
        }
      },
    );
  }

  List<Widget> _buildMenuOptions(BuildContext context, SettingState state) {
    final List<MenuOption> menuOptions = [
      MenuOption(
        title: AppConstants.aboutAccount,
        icon: const Icon(Icons.person, color: Colors.white, size: 24),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserProfilePage()),
          );

          if (result == true) {
            context.read<SettingBloc>().add(SettingGetUserProfileEvent());
          }
        },
      ),
      MenuOption(
        title: AppConstants.search,
        icon: SvgPicture.asset(AppIcons.search.svgAssetPath),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.search);
        },
      ),
      MenuOption(
        title: AppConstants.myReviews,
        icon: SvgPicture.asset(AppIcons.review.svgAssetPath, width: 24),
        onTap: () {},
      ),
      MenuOption(
        title: AppConstants.privacy,
        icon: SvgPicture.asset(AppIcons.privacy.svgAssetPath, width: 24),
        onTap: () {},
      ),
      MenuOption(
        title: AppConstants.helpCentre,
        icon: SvgPicture.asset(AppIcons.help.svgAssetPath, width: 24),
        onTap: () {},
      ),
      MenuOption(
        title: AppConstants.aboutThisApp,
        icon: const Icon(Icons.info, color: Colors.white),
        onTap: () {},
      ),
    ];

    if (SharedPrefer.sharedPrefer.getUserToken().isNotEmpty) {
      menuOptions.add(
        MenuOption(
          title: AppConstants.logout,
          icon: SvgPicture.asset(AppIcons.logout.svgAssetPath, width: 24),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return DialogConfirmLogout(
                  onTapYes: () {
                    context.read<SettingBloc>().add(SettingLogoutEvent());
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        ),
      );
    } else {
      menuOptions.add(
        MenuOption(
          title: AppConstants.login,
          icon: SvgPicture.asset(AppIcons.login.svgAssetPath, width: 24),
          onTap: () => Navigator.pushNamed(context, AppRoutes.login),
        ),
      );
    }

    return menuOptions.asMap().entries.map((entry) {
      final index = entry.key;
      final option = entry.value;

      return Padding(
        padding: EdgeInsets.only(bottom: index == 2 ? 24 : 6),
        child: CustomButton(
          title: option.title,
          isFullWidth: true,
          prefix: option.icon,
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 8),
          backgroundColor: AppColors.arsenic,
          isExpanded: true,
          titleAlign: TextAlign.start,
          titleStyle: AppTextStyles.beVietNamProStyles.regular14White,
          btnMainAxisAlignment: MainAxisAlignment.start,
          btnCrossAxisAlignment: CrossAxisAlignment.center,
          textMarginLeft: 12,
          borderRadius: 0,
          suffix: SvgPicture.asset(AppIcons.arrowRight.svgAssetPath, width: 24),
          onTap: option.onTap,
        ),
      );
    }).toList();
  }
}
