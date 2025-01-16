import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/utils/input_validation_helper.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginChangeEmailPasswordEvent>(_onLoginChangeEmailPasswordEvent);
    on<LoginWithGoogleEvent>(_onLoginWithGoogleEvent);
    on<LoginWithFacebookEvent>(_onLoginWithFacebookEvent);
    on<LoginWithEmailPasswordEvent>(_onLoginWithEmailPasswordEvent);
  }

  void _onLoginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {}

  void _onLoginChangeEmailPasswordEvent(
      LoginChangeEmailPasswordEvent event, Emitter emit) async {
    final loginValues = state.copyWith(
      inputEmail: event.inputEmail,
      inputPassword: event.inputPassword,
    );
    final isShowEmailMessage = state.inputEmail != loginValues.inputEmail
        ? false
        : state.isShowEmailMessage;
    final isShowPasswordMessage =
        state.inputPassword != loginValues.inputPassword
            ? false
            : state.isShowPasswordMessage;

    final isEnableSignUp = loginValues.inputEmail.isNotEmpty &&
        loginValues.inputPassword.isNotEmpty;
    emit(loginValues.copyWith(
      isEnabled: isEnableSignUp,
      isShowEmailMessage: isShowEmailMessage,
      isShowPasswordMessage: isShowPasswordMessage,
    ));
  }

  void _onLoginWithEmailPasswordEvent(
      LoginWithEmailPasswordEvent event, Emitter<LoginState> emit) async {
    final validEmail = InputValidationHelper.validateEmail(state.inputEmail);
    final validPassword =
        InputValidationHelper.validatePassword(state.inputPassword);
    emit(state.copyWith(
      isShowEmailMessage: validEmail != null,
      isShowPasswordMessage: validPassword != null,
      messageInputEmail: validEmail,
      messageInputPassword: validPassword,
    ));
    UserModel userModel = UserModel(
      email: state.inputEmail,
      password: state.inputPassword,
    );
    if (validEmail == null && validPassword == null) {
      emit(state.copyWith(status: LoginStatus.processing));

      final result = await UserRepository().login(userModel);
      result.fold(
        (errorMessage) {
          bool isEmailError = errorMessage.toLowerCase().contains("email");
          bool isPasswordError =
              errorMessage.toLowerCase().contains("password");

          emit(state.copyWith(
            status: LoginStatus.failure,
            isShowEmailMessage: isEmailError,
            isShowPasswordMessage: isPasswordError,
            messageInputEmail: isEmailError ? errorMessage : "",
            messageInputPassword: isPasswordError ? errorMessage : "",
          ));
        },
        (response) {
          emit(state.copyWith(
            status: LoginStatus.success,
            // userModel: userModel,
          ));
        },
      );
    }
  }

  void _onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter emit) async {}

  void _onLoginWithFacebookEvent(
      LoginWithFacebookEvent event, Emitter emit) async {}
}
