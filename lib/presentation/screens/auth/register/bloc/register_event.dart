import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class RegisterValuesChangedEvent extends RegisterEvent {
  final String? inputEmail;
  final String? inputPassword;
  final String? inputConfirmPassword;

  RegisterValuesChangedEvent({
    this.inputEmail,
    this.inputPassword,
    this.inputConfirmPassword,
  });

  @override
  List<Object?> get props => [inputEmail, inputPassword, inputConfirmPassword];
}

class RegisterWithEmailSubmitEvent extends RegisterEvent {}
