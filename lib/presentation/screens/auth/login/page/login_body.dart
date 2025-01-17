import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_clickable_text.dart';
import 'package:movie_marks/presentation/components/custom_edit_text.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';
import 'package:movie_marks/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:movie_marks/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:movie_marks/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:movie_marks/presentation/screens/auth/login/widget/divider_line.dart';

class LoginBody extends StatefulWidget {
  final bool isStayOnPage;
  final Function()? navigate;

  const LoginBody({super.key, this.isStayOnPage = false, this.navigate});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.status == LoginStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
        if (state.status == LoginStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main,
            (route) => false,
          );
          Fluttertoast.showToast(
            msg: AppConstants.loginSuccess,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            appBar: AppBar(
              backgroundColor: AppColors.charlestonGreen,
              iconTheme: const IconThemeData(
                size: 32,
              ),
              leading: Container(
                margin: const EdgeInsets.only(left: 29),
                padding: EdgeInsets.zero,
                child: CustomButton(
                  prefix: SvgPicture.asset(AppIcons.arrowBack.svgAssetPath),
                  backgroundColor: AppColors.arsenic,
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ),
              leadingWidth: kToolbarHeight + 29,
              toolbarHeight: 40,
            ),
            body: SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 29),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTitle(
                            title: AppConstants.welcomeToMM,
                            style: AppTextStyles.beVietNamProStyles.bold24White,
                            isFullWidth: true,
                          ),
                          CustomTitle(
                            title: AppConstants.loginToContinue,
                            style: AppTextStyles.beVietNamProStyles.bold16White,
                            isFullWidth: true,
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          CustomTitle(
                            title: AppConstants.email,
                            textAlign: TextAlign.start,
                            isFullWidth: true,
                            style:
                                AppTextStyles.beVietNamProStyles.regular14White,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomEditText(
                            backgroundColor: AppColors.charlestonGreen,
                            prefix: const Icon(
                              Icons.email,
                              size: 24,
                              color: AppColors.brightGray,
                            ),
                            initialValue: state.inputEmail,
                            textStyle: state.isShowEmailMessage
                                ? AppTextStyles
                                    .beVietNamProStyles.regular14BrinkPink
                                : AppTextStyles
                                    .beVietNamProStyles.regular14White,
                            borderColor: state.isShowEmailMessage
                                ? AppColors.brinkPink
                                : AppColors.brightGray,
                            cursorColor: state.isShowEmailMessage
                                ? AppColors.brinkPink
                                : AppColors.brightGray,
                            maxLength: 255,
                            onChanged: (email) {
                              context.read<LoginBloc>().add(
                                  LoginChangeEmailPasswordEvent(
                                      inputEmail: email));
                            },
                            onLostFocus: (email) {
                              context.read<LoginBloc>().add(
                                  LoginChangeEmailPasswordEvent(
                                      inputEmail: email.trim()));
                            },
                          ),
                          state.isShowEmailMessage
                              ? CustomTitle(
                                  title: state.messageInputEmail,
                                  isFullWidth: true,
                                  style: AppTextStyles
                                      .beVietNamProStyles.regular14BrinkPink,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTitle(
                            title: AppConstants.password,
                            textAlign: TextAlign.left,
                            isFullWidth: true,
                            style:
                                AppTextStyles.beVietNamProStyles.regular14White,
                          ),
                          CustomEditText(
                            backgroundColor: AppColors.charlestonGreen,
                            prefix: const Icon(
                              Icons.lock,
                              size: 24,
                              color: AppColors.brightGray,
                            ),
                            isPasswordInput: true,
                            initialValue: state.inputPassword,
                            textStyle: state.isShowPasswordMessage
                                ? AppTextStyles
                                    .beVietNamProStyles.regular14BrinkPink
                                : AppTextStyles
                                    .beVietNamProStyles.regular14White,
                            borderColor: state.isShowPasswordMessage
                                ? AppColors.brinkPink
                                : AppColors.brightGray,
                            cursorColor: state.isShowPasswordMessage
                                ? AppColors.brinkPink
                                : AppColors.brightGray,
                            onChanged: (password) {
                              context.read<LoginBloc>().add(
                                  LoginChangeEmailPasswordEvent(
                                      inputPassword: password));
                            },
                            onLostFocus: (password) {
                              context.read<LoginBloc>().add(
                                  LoginChangeEmailPasswordEvent(
                                      inputPassword: password.trim()));
                            },
                          ),
                          state.isShowPasswordMessage
                              ? CustomTitle(
                                  title: state.messageInputPassword,
                                  isFullWidth: true,
                                  style: AppTextStyles
                                      .beVietNamProStyles.regular14BrinkPink,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 12,
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          CustomButton(
                            title: AppConstants.login,
                            titleStyle:
                                AppTextStyles.beVietNamProStyles.bold16White,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            isFullWidth: true,
                            backgroundColor: state.isEnabled
                                ? AppColors.eucalyptus
                                : AppColors.arsenic,
                            onTap: state.isEnabled
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginWithEmailPasswordEvent());
                                  }
                                : null,
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          const DividerLine(),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomButton(
                            prefix: SvgPicture.asset(
                              AppIcons.google.svgAssetPath,
                              width: 32,
                            ),
                            title: AppConstants.withGG,
                            onTap: () {},
                            isExpanded: true,
                            textCrossAxisAlignment: CrossAxisAlignment.center,
                            backgroundColor: AppColors.arsenic,
                            titleStyle:
                                AppTextStyles.beVietNamProStyles.bold16White,
                            padding: const EdgeInsets.symmetric(vertical: 8)
                                .copyWith(left: 12),
                            isFullWidth: true,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomButton(
                            prefix: SvgPicture.asset(
                              AppIcons.fbBlue.svgAssetPath,
                              width: 32,
                            ),
                            title: AppConstants.withFB,
                            isExpanded: true,
                            onTap: () {},
                            backgroundColor: AppColors.arsenic,
                            textCrossAxisAlignment: CrossAxisAlignment.center,
                            titleStyle:
                                AppTextStyles.beVietNamProStyles.bold16White,
                            padding: const EdgeInsets.symmetric(vertical: 8)
                                .copyWith(left: 12),
                            isFullWidth: true,
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          CustomClickableText(
                            title: AppConstants.dontHaveAccount,
                            subTitle: " ${AppConstants.registerNow}",
                            subTitleStyle: AppTextStyles
                                .beVietNamProStyles.semiBold14White,
                            onTapSub: () {
                              Navigator.pushNamed(context, AppRoutes.register);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
