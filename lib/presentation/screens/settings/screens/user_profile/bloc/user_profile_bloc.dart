import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_event.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_state.dart';
import 'package:movie_marks/utils/input_validation_helper.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository = UserRepository();
  final ImagePicker _picker = ImagePicker();

  UserProfileBloc() : super(UserProfileState.initial()) {
    on<UserProfileInitialEvent>(_onUserProfileInitialEvent);
    on<UserProfilePickImageEvent>(_onUserProfilePickImageEvent);
    on<UserProfileValueChangedEvent>(_onUserProfileValueChangedEvent);
    on<UserProfileSubmitEvent>(_onUserProfileSubmitEvent);
  }

  void _onUserProfileInitialEvent(
      UserProfileInitialEvent event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.getUserInfo();
    result.fold((error) {}, (response) {
      emit(state.copyWith(user: response));
    });
  }

  void _onUserProfilePickImageEvent(
      UserProfilePickImageEvent event, Emitter<UserProfileState> emit) async {
    try {
      final pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        final isEnable = (state.user?.username?.isNotEmpty ?? true) &&
            (state.user?.fullName?.isNotEmpty ?? true);
        emit(state.copyWith(
            imageFile: File(pickedFile.path), isEnabled: isEnable));
      }
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure));
    }
  }

  void _onUserProfileValueChangedEvent(UserProfileValueChangedEvent event,
      Emitter<UserProfileState> emit) async {
    final isShowUsernameMessage = state.inputUsername != event.username
        ? false
        : state.isShowUsernameMessage;
    final isShowFullNameMessage = state.inputFullName != event.fullName
        ? false
        : state.isShowFullNameMessage;

    final isEnable = (event.username?.isNotEmpty ?? true) &&
        (event.fullName?.isNotEmpty ??
            true && state.imageFile.toString().isNotEmpty);
    emit(state.copyWith(
        inputUsername: event.username,
        inputFullName: event.fullName,
        user: state.user
            ?.copyWith(username: event.username, fullName: event.fullName),
        isShowFullNameMessage: isShowFullNameMessage,
        isShowUsernameMessage: isShowUsernameMessage,
        isEnabled: isEnable));
  }

  void _onUserProfileSubmitEvent(
      UserProfileSubmitEvent event, Emitter<UserProfileState> emit) async {
    final validUsername =
        InputValidationHelper.validateUsername(state.user?.username ?? "");
    final validFullName =
        InputValidationHelper.validateFullName(state.user?.fullName ?? "");

    emit(state.copyWith(
      isShowUsernameMessage: validUsername != null,
      messageInputUsername: validUsername,
      isShowFullNameMessage: validFullName != null,
      messageInputFullName: validFullName,
    ));
    if (validUsername == null && validFullName == null) {
      emit(state.copyWith(status: UserProfileStatus.processing));
      final result =
          await userRepository.editUserProfile(state.user, state.imageFile);
      result.fold((l) {
        emit(state.copyWith(status: UserProfileStatus.failure));
      }, (r) {
        emit(state.copyWith(
          status: UserProfileStatus.editUserSuccess,
        ));
      });
    }
  }
}
