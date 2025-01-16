import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/user_model.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();
}

final class VerificationInitialEvent extends VerificationEvent {
  final UserModel? userModel;

  const VerificationInitialEvent({
    this.userModel,
  });

  @override
  List<Object?> get props => [userModel];
}

class VerificationCodeChangedEvent extends VerificationEvent {
  final String inputCode;

  const VerificationCodeChangedEvent(this.inputCode);

  @override
  List<Object?> get props => [inputCode];
}

class VerificationStartTimerEvent extends VerificationEvent {
  @override
  List<Object?> get props => [];
}

class VerificationResendEvent extends VerificationEvent {
  @override
  List<Object?> get props => [];
}

class VerificationSubmitEvent extends VerificationEvent {
  @override
  List<Object?> get props => [];
}
