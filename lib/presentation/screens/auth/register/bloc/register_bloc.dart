import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:movie_marks/presentation/screens/auth/register/bloc/register_state.dart';
import 'package:movie_marks/utils/input_validation_helper.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterValuesChangedEvent>(onSignUpValuesChangedEvent);
    on<RegisterWithEmailSubmitEvent>(_onRegisterWithEmailSubmitEvent);
  }

  void onSignUpValuesChangedEvent(
    RegisterValuesChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    final registerValue = state.copyWith(
      inputEmail: event.inputEmail,
      inputPassword: event.inputPassword,
      inputConfirmPassword: event.inputConfirmPassword,
    );

    final isShowEmailMessage = state.inputEmail != registerValue.inputEmail
        ? false
        : state.isShowEmailMessage;
    final isShowPasswordMessage =
        state.inputPassword != registerValue.inputPassword
            ? false
            : state.isShowPasswordMessage;
    final isShowConfirmPasswordMessage =
        state.inputConfirmPassword != registerValue.inputConfirmPassword
            ? false
            : state.isShowConfirmPasswordMessage;

    final isEnable = registerValue.inputEmail.isNotEmpty &&
        registerValue.inputPassword.isNotEmpty &&
        registerValue.inputConfirmPassword.isNotEmpty;

    emit(registerValue.copyWith(
        isShowEmailMessage: isShowEmailMessage,
        isShowPasswordMessage: isShowPasswordMessage,
        isShowConfirmPasswordMessage: isShowConfirmPasswordMessage,
        isEnabled: isEnable));
  }

  void _onRegisterWithEmailSubmitEvent(
    RegisterWithEmailSubmitEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final validEmail = InputValidationHelper.validateEmail(state.inputEmail);
    final validPassword =
        InputValidationHelper.validatePassword(state.inputPassword);
    final doMatchPassword = state.inputPassword == state.inputConfirmPassword;

    emit(state.copyWith(
      isShowEmailMessage: validEmail != null,
      isShowPasswordMessage: validPassword != null,
      isShowConfirmPasswordMessage: !doMatchPassword,
      messageInputEmail: validEmail,
      messageInputPassword: validPassword,
      messageInputConfirmPassword:
          doMatchPassword ? "" : AppConstants.errorMessageConfirmPassword,
    ));

    UserModel userModel = UserModel(
      email: state.inputEmail,
      password: state.inputPassword,
    );

    if (validEmail == null && validPassword == null && doMatchPassword) {
      emit(state.copyWith(status: RegisterStatus.loading));

      final result = await UserRepository().sendVerificationCode(state.inputEmail);
      result.fold((error) {
        emit(state.copyWith(
          status: RegisterStatus.error,
          isShowEmailMessage: true,
          messageInputEmail: error,
        ));
      }, (response) {
        emit(state.copyWith(
            status: RegisterStatus.success, userModel: userModel));
      });
    }
  }
}
