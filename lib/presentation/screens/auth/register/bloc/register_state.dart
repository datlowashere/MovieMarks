import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/user_model.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  final RegisterStatus status;
  final bool isEnabled;
  final String inputEmail;
  final String inputPassword;
  final String inputConfirmPassword;
  final String messageInputEmail;
  final String messageInputPassword;
  final String messageInputConfirmPassword;
  final bool isShowEmailMessage;
  final bool isShowPasswordMessage;
  final bool isShowConfirmPasswordMessage;
  final UserModel? userModel;

  const RegisterState(
      {this.status = RegisterStatus.initial,
      this.isEnabled = false,
      this.inputEmail = "",
      this.inputPassword = "",
      this.inputConfirmPassword = "",
      this.messageInputEmail = "",
      this.messageInputPassword = "",
      this.messageInputConfirmPassword = "",
      this.isShowEmailMessage = false,
      this.isShowPasswordMessage = false,
      this.isShowConfirmPasswordMessage = false,
      this.userModel});

  RegisterState copyWith(
      {RegisterStatus? status,
      bool? isEnabled,
      String? inputEmail,
      String? inputPassword,
      String? inputConfirmPassword,
      String? messageInputEmail,
      String? messageInputPassword,
      String? messageInputConfirmPassword,
      bool? isShowEmailMessage,
      bool? isShowPasswordMessage,
      bool? isShowConfirmPasswordMessage,
      bool? isShowPassword,
      bool? isShowConfirmPassword,
      UserModel? userModel}) {
    return RegisterState(
        status: status ?? this.status,
        isEnabled: isEnabled ?? this.isEnabled,
        inputEmail: inputEmail ?? this.inputEmail,
        inputPassword: inputPassword ?? this.inputPassword,
        inputConfirmPassword: inputConfirmPassword ?? this.inputConfirmPassword,
        messageInputEmail: messageInputEmail ?? this.messageInputEmail,
        messageInputPassword: messageInputPassword ?? this.messageInputPassword,
        messageInputConfirmPassword:
            messageInputConfirmPassword ?? this.messageInputConfirmPassword,
        isShowEmailMessage: isShowEmailMessage ?? this.isShowEmailMessage,
        isShowPasswordMessage:
            isShowPasswordMessage ?? this.isShowPasswordMessage,
        isShowConfirmPasswordMessage:
            isShowConfirmPasswordMessage ?? this.isShowConfirmPasswordMessage,
        userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [
        status,
        isEnabled,
        inputEmail,
        inputPassword,
        inputConfirmPassword,
        messageInputEmail,
        messageInputPassword,
        messageInputConfirmPassword,
        isShowEmailMessage,
        isShowPasswordMessage,
        isShowConfirmPasswordMessage,
        userModel
      ];
}
