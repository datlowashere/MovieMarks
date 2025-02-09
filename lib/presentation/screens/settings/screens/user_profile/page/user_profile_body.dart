import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_edit_text.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_event.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_state.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/widgets/appbar_profile.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/widgets/bottom_sheet_camera_option.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/widgets/avatar_picker.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        state.status == UserProfileStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
        if (state.status == UserProfileStatus.editUserSuccess) {
          Fluttertoast.showToast(msg: AppConstants.updateUserSuccess);
        }
      },
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            body: SafeArea(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 29).copyWith(top: 18),
              child: Column(
                children: [
                  AppbarProfile(
                    onTapBack: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  AvatarPicker(
                    url: state.user?.avatar ?? "",
                    imageLocal: state.imageFile,
                    width: 120,
                    height: 120,
                    radius: 16,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return BottomSheetCameraOption(
                            onTapCamera: () {
                              Navigator.of(context).pop();
                              context.read<UserProfileBloc>().add(
                                  const UserProfilePickImageEvent(
                                      ImageSource.camera));
                            },
                            onTapGallery: () {
                              Navigator.of(context).pop();
                              context.read<UserProfileBloc>().add(
                                  const UserProfilePickImageEvent(
                                      ImageSource.gallery));
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTitle(
                    title: AppConstants.email,
                    style: AppTextStyles.beVietNamProStyles.regular14White,
                    isFullWidth: true,
                  ),
                  CustomEditText(
                    backgroundColor: AppColors.charlestonGreen,
                    prefix: const Icon(
                      Icons.email,
                      size: 24,
                      color: AppColors.brightGray,
                    ),
                    enable: false,
                    initialValue: state.user?.email,
                    textStyle: AppTextStyles.beVietNamProStyles.regular14White,
                    borderColor: AppColors.brightGray,
                    cursorColor: AppColors.brightGray,
                    maxLength: 255,
                    onChanged: (username) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              username: username.trim()));
                    },
                    onLostFocus: (username) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              username: username.trim()));
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTitle(
                    title: AppConstants.username,
                    style: AppTextStyles.beVietNamProStyles.regular14White,
                    isFullWidth: true,
                  ),
                  CustomEditText(
                    backgroundColor: AppColors.charlestonGreen,
                    prefix: const Icon(
                      Icons.account_box,
                      size: 24,
                      color: AppColors.brightGray,
                    ),
                    initialValue: state.user?.username,
                    textStyle: state.isShowUsernameMessage
                        ? AppTextStyles.beVietNamProStyles.regular14BrinkPink
                        : AppTextStyles.beVietNamProStyles.regular14White,
                    borderColor: state.isShowUsernameMessage
                        ? AppColors.brinkPink
                        : AppColors.brightGray,
                    cursorColor: state.isShowUsernameMessage
                        ? AppColors.brinkPink
                        : AppColors.brightGray,
                    maxLength: 255,
                    onChanged: (username) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              username: username.trim()));
                    },
                    onLostFocus: (username) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              username: username.trim()));
                    },
                  ),
                  state.isShowUsernameMessage
                      ? CustomTitle(
                          title: state.messageInputUsername,
                          isFullWidth: true,
                          style: AppTextStyles
                              .beVietNamProStyles.regular14BrinkPink,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTitle(
                    title: AppConstants.fullName,
                    style: AppTextStyles.beVietNamProStyles.regular14White,
                    isFullWidth: true,
                  ),
                  CustomEditText(
                    backgroundColor: AppColors.charlestonGreen,
                    prefix: const Icon(
                      Icons.perm_contact_calendar_outlined,
                      size: 24,
                      color: AppColors.brightGray,
                    ),
                    initialValue: state.user?.fullName,
                    textStyle: state.isShowFullNameMessage
                        ? AppTextStyles.beVietNamProStyles.regular14BrinkPink
                        : AppTextStyles.beVietNamProStyles.regular14White,
                    borderColor: state.isShowFullNameMessage
                        ? AppColors.brinkPink
                        : AppColors.brightGray,
                    cursorColor: state.isShowFullNameMessage
                        ? AppColors.brinkPink
                        : AppColors.brightGray,
                    maxLength: 255,
                    onChanged: (fullName) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              fullName: fullName.trim()));
                    },
                    onLostFocus: (fullName) {
                      context.read<UserProfileBloc>().add(
                          UserProfileValueChangedEvent(
                              fullName: fullName.trim()));
                    },
                  ),
                  state.isShowFullNameMessage
                      ? CustomTitle(
                          title: state.messageInputFullName,
                          isFullWidth: true,
                          style: AppTextStyles
                              .beVietNamProStyles.regular14BrinkPink,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 29,
                  ),
                  CustomButton(
                    title: AppConstants.save,
                    onTap: state.isEnabled
                        ? () {
                            FocusScope.of(context).unfocus();
                            context
                                .read<UserProfileBloc>()
                                .add(const UserProfileSubmitEvent());
                          }
                        : null,
                    backgroundColor: state.isEnabled
                        ? AppColors.eucalyptus
                        : AppColors.arsenic,
                    titleStyle: AppTextStyles.beVietNamProStyles.bold16White,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    isFullWidth: true,
                  )
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
