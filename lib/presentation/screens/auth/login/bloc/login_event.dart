import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

final class LoginWithEmailVisibleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

final class LoginChangeEmailPasswordEvent extends LoginEvent {
  final String? inputEmail;
  final String? inputPassword;

  const LoginChangeEmailPasswordEvent({
    this.inputEmail,
    this.inputPassword,
  });

  @override
  List<Object?> get props => [
        inputEmail,
        inputPassword,
      ];
}

final class LoginWithGoogleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

final class LoginWithFacebookEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

final class LoginWithEmailPasswordEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
