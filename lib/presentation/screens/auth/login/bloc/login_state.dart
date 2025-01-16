import 'package:equatable/equatable.dart';

enum LoginStatus {
  initial,
  processing,
  success,
  dismiss,
  failure,
}

final class LoginState extends Equatable {
  final LoginStatus status;
  final bool isVisible;
  final bool isEnabled;
  final String inputEmail;
  final String inputPassword;
  final String googleButton;
  final String facebookButton;
  final String messageInputEmail;
  final String messageInputPassword;
  final bool isShowEmailMessage;
  final bool isShowPasswordMessage;
  final bool isShowErrorBorder;

  const LoginState({
    required this.status,
    this.isVisible = false,
    this.isEnabled = false,
    this.inputEmail = '',
    this.inputPassword = '',
    this.googleButton = '',
    this.facebookButton = '',
    this.messageInputEmail = "",
    this.messageInputPassword = "",
    this.isShowEmailMessage = false,
    this.isShowPasswordMessage = false,
    this.isShowErrorBorder = false,
  });

  static LoginState initial() => const LoginState(
        status: LoginStatus.initial,
        isVisible: false,
        isEnabled: false,
        inputEmail: '',
        inputPassword: '',
        googleButton: '',
        facebookButton: '',
        messageInputEmail: '',
        messageInputPassword: '',
        isShowEmailMessage: false,
        isShowPasswordMessage: false,
        isShowErrorBorder: false,
      );

  LoginState copyWith({
    LoginStatus? status,
    bool? isVisible,
    bool? isEnabled,
    String? inputEmail,
    String? inputPassword,
    String? googleButton,
    String? facebookButton,
    String? messageInputEmail,
    String? messageInputPassword,
    bool? isShowEmailMessage,
    bool? isShowPasswordMessage,
    bool? isShowErrorBorder,
  }) {
    return LoginState(
      status: status ?? this.status,
      isVisible: isVisible ?? this.isVisible,
      isEnabled: isEnabled ?? this.isEnabled,
      inputEmail: inputEmail ?? this.inputEmail,
      inputPassword: inputPassword ?? this.inputPassword,
      googleButton: googleButton ?? this.googleButton,
      facebookButton: facebookButton ?? this.facebookButton,
      messageInputEmail: messageInputEmail ?? this.messageInputEmail,
      messageInputPassword: messageInputPassword ?? this.messageInputPassword,
      isShowEmailMessage: isShowEmailMessage ?? this.isShowEmailMessage,
      isShowPasswordMessage:
          isShowPasswordMessage ?? this.isShowPasswordMessage,
      isShowErrorBorder: isShowErrorBorder ?? this.isShowErrorBorder,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isVisible,
        isEnabled,
        inputEmail,
        inputPassword,
        googleButton,
        facebookButton,
        messageInputEmail,
        messageInputPassword,
        isShowEmailMessage,
        isShowPasswordMessage,
        isShowErrorBorder,
      ];
}
