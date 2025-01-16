import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_clickable_text.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_bloc.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_event.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_state.dart';
import 'package:movie_marks/presentation/screens/main/page/main_page.dart';

class VerificationBody extends StatefulWidget {
  const VerificationBody({super.key});

  @override
  State<VerificationBody> createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationBloc, VerificationState>(
      listener: (context, state) {
        state.status == VerificationStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
        if (state.status == VerificationStatus.success) {
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (Route<dynamic> route) => false,
          );
          Fluttertoast.showToast(msg: AppConstants.registerSuccessful);
        }
      },
      child: BlocBuilder<VerificationBloc, VerificationState>(
          builder: (context, state) {
        return Dialog(
          backgroundColor: AppColors.charlestonGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTitle(
                        title: AppConstants.verification,
                        style: AppTextStyles.beVietNamProStyles.semiBold18White,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        AppIcons.close.svgAssetPath,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: AppConstants.sendCode,
                    style: AppTextStyles.beVietNamProStyles.regular14White,
                    children: [
                      TextSpan(
                        text: " ${state.userModel?.email}.",
                        style: AppTextStyles.beVietNamProStyles.bold16White,
                      ),
                      TextSpan(
                        text: " ${AppConstants.enterCode}",
                        style: AppTextStyles.beVietNamProStyles.regular14White,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                OtpTextField(
                    numberOfFields: 6,
                    enabledBorderColor: AppColors.arsenic,
                    focusedBorderColor: AppColors.brightGray,
                    cursorColor: AppColors.brightGray,
                    textStyle: AppTextStyles.beVietNamProStyles.bold16White,
                    borderWidth: 4.0,
                    onCodeChanged: (code) {
                      context
                          .read<VerificationBloc>()
                          .add(VerificationCodeChangedEvent(code));
                    },
                    onSubmit: (code) {
                      context
                          .read<VerificationBloc>()
                          .add(VerificationCodeChangedEvent(code));
                    }),
                const SizedBox(
                  height: 12,
                ),
                state.isShowMessageCode
                    ? CustomTitle(
                        title: state.messageCode,
                        isFullWidth: true,
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyles.beVietNamProStyles.regular14BrinkPink,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 22,
                ),
                CustomClickableText(
                  subTitleStyle:
                      AppTextStyles.beVietNamProStyles.regular16White,
                  subTitle: state.remainingSeconds > 0
                      ? "${state.remainingSeconds}s"
                      : "${AppConstants.resendCode} ",
                  onTapSub: state.remainingSeconds == 0
                      ? () {
                          context
                              .read<VerificationBloc>()
                              .add(VerificationResendEvent());
                        }
                      : null,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  title: AppConstants.send,
                  onTap: state.isEnabled
                      ? () {
                          FocusScope.of(context).unfocus();
                          context
                              .read<VerificationBloc>()
                              .add(VerificationSubmitEvent());
                        }
                      : null,
                  backgroundColor: state.isEnabled
                      ? AppColors.eucalyptus
                      : AppColors.arsenic,
                  titleStyle: AppTextStyles.beVietNamProStyles.bold16White,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
