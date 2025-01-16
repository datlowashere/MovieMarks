import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_clickable_text.dart';
import 'package:movie_marks/presentation/components/custom_edit_text.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';
import 'package:movie_marks/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:movie_marks/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:movie_marks/presentation/screens/auth/register/bloc/register_state.dart';
import 'package:movie_marks/presentation/screens/auth/verification/body/verification_page.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
      state.status == RegisterStatus.loading
          ? EasyLoading.show()
          : EasyLoading.dismiss();
      if (state.status == RegisterStatus.success) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return VerificationPage(userModel: state.userModel);
          },
        );
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.charlestonGreen,
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
                          title: AppConstants.createAccount,
                          style: AppTextStyles.beVietNamProStyles.bold24White,
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
                              : AppTextStyles.beVietNamProStyles.regular14White,
                          borderColor: state.isShowEmailMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          cursorColor: state.isShowEmailMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          maxLength: 255,
                          onChanged: (email) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(inputEmail: email));
                          },
                          onLostFocus: (email) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(
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
                              : AppTextStyles.beVietNamProStyles.regular14White,
                          borderColor: state.isShowPasswordMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          cursorColor: state.isShowPasswordMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          onChanged: (password) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(
                                    inputPassword: password));
                          },
                          onLostFocus: (password) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(
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
                        CustomTitle(
                          title: AppConstants.confirmPassword,
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
                          initialValue: state.inputConfirmPassword,
                          textStyle: state.isShowConfirmPasswordMessage
                              ? AppTextStyles
                                  .beVietNamProStyles.regular14BrinkPink
                              : AppTextStyles.beVietNamProStyles.regular14White,
                          borderColor: state.isShowConfirmPasswordMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          cursorColor: state.isShowConfirmPasswordMessage
                              ? AppColors.brinkPink
                              : AppColors.brightGray,
                          onChanged: (password) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(
                                    inputConfirmPassword: password));
                          },
                          onLostFocus: (password) {
                            context.read<RegisterBloc>().add(
                                RegisterValuesChangedEvent(
                                    inputConfirmPassword: password.trim()));
                          },
                        ),
                        state.isShowConfirmPasswordMessage
                            ? CustomTitle(
                                title: state.messageInputConfirmPassword,
                                isFullWidth: true,
                                style: AppTextStyles
                                    .beVietNamProStyles.regular14BrinkPink,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 29,
                        ),
                        CustomButton(
                          title: AppConstants.register,
                          onTap: state.isEnabled
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterWithEmailSubmitEvent());
                                }
                              : null,
                          backgroundColor: state.isEnabled
                              ? AppColors.eucalyptus
                              : AppColors.arsenic,
                          titleStyle:
                              AppTextStyles.beVietNamProStyles.bold16White,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          isFullWidth: true,
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        CustomClickableText(
                          title: AppConstants.hasAccount,
                          subTitle: " ${AppConstants.backToLogin}",
                          subTitleStyle:
                              AppTextStyles.beVietNamProStyles.semiBold14White,
                          onTapSub: () {
                            // Navigator.of(context).pop();
                            Navigator.pushNamed(context, AppRoutes.login);
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
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
