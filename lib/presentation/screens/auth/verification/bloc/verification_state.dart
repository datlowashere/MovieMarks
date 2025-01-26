import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/user_model.dart';

enum VerificationStatus {
  initial,
  processing,
  success,
  failure,
}

final class VerificationState extends Equatable {
  final VerificationStatus? status;
  final UserModel? userModel;
  final bool isEnabled, isShowMessageCode;
  final String inputCode;
  final int remainingSeconds;
  final String messageCode;

  const VerificationState({
    this.status,
    this.userModel,
    this.isEnabled = false,
    this.isShowMessageCode = false,
    this.inputCode = "",
    this.remainingSeconds = 10,
    this.messageCode = "",
  });

  static VerificationState initial() => const VerificationState(
        status: VerificationStatus.initial,
      );

  VerificationState copyWith({
    VerificationStatus? status,
    UserModel? userModel,
    bool? isEnabled,
    bool? isShowMessageOtp,
    String? inputCode,
    int? remainingSeconds,
    String? messageCode,
  }) {
    return VerificationState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      isEnabled: isEnabled ?? this.isEnabled,
      isShowMessageCode: isShowMessageOtp ?? isShowMessageCode,
      inputCode: inputCode ?? this.inputCode,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      messageCode: messageCode ?? this.messageCode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userModel,
        isEnabled,
        isShowMessageCode,
        inputCode,
        remainingSeconds,
        messageCode
      ];
}
