import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_event.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_state.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(listener: (context, state) {
      state.status == SettingStatus.processing
          ? EasyLoading.show()
          : EasyLoading.dismiss();

      if (state.status == SettingStatus.success) {
        Fluttertoast.showToast(
          msg: "Logout successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }, child: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.charlestonGreen,
        body: SafeArea(
            child: Column(
          children: [
            Center(
              child: Text(
                "Settings +09",
                style: AppTextStyles.beVietNamProStyles.regular16Black,
              ),
            ),
            SharedPrefer.sharedPrefer.getUserToken().isNotEmpty
                ? CustomButton(
                    title: "logout",
                    onTap: () {
                      context.read<SettingBloc>().add(SettingLogoutEvent());
                    },
                  )
                : CustomButton(
                    title: "login",
                    prefix: SvgPicture.asset(
                      AppIcons.close.svgAssetPath,
                      height: 16,
                      width: 16,

                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                  ),
          ],
        )),
      );
    }));
  }
}
