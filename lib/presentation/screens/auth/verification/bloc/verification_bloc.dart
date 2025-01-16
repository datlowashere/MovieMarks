import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_event.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  Timer? timer;

  VerificationBloc() : super(VerificationState.initial()) {
    on<VerificationInitialEvent>(_onVerificationInitialEvent);
    on<VerificationCodeChangedEvent>(_onVerificationCodeChangedEvent);
    on<VerificationStartTimerEvent>(_onVerificationStartTimerEvent);
    on<VerificationResendEvent>(_onVerificationResendEvent);
    on<VerificationSubmitEvent>(_onVerificationSubmitEvent);
  }

  void _onVerificationInitialEvent(
      VerificationInitialEvent event, Emitter<VerificationState> emit) {
    emit(state.copyWith(
        status: VerificationStatus.initial, userModel: event.userModel));
    add(VerificationStartTimerEvent());
  }

  void _onVerificationStartTimerEvent(
    VerificationStartTimerEvent event,
    Emitter<VerificationState> emit,
  ) async {
    timer?.cancel();
    emit(state.copyWith(remainingSeconds: 60));

    await Future.forEach(List.generate(60, (index) => index), (index) async {
      await Future.delayed(const Duration(seconds: 1));
      if (emit.isDone) return;
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
    });
  }

  void _onVerificationCodeChangedEvent(
    VerificationCodeChangedEvent event,
    Emitter<VerificationState> emit,
  ) {
    final isShowMessageOtp =
        state.inputCode != event.inputCode ? false : state.isShowMessageCode;
    emit(state.copyWith(
        inputCode: event.inputCode,
        isEnabled: event.inputCode.length == 6,
        isShowMessageOtp: isShowMessageOtp));
  }

  void _onVerificationResendEvent(
    VerificationResendEvent event,
    Emitter<VerificationState> emit,
  ) async {
    final email = state.userModel?.email ?? "";
    final result = await UserRepository().sendVerificationCode(email);
    result.fold(
      (error) {
        emit(state.copyWith(
          status: VerificationStatus.failure,
          isShowMessageOtp: true,
          messageCode: error,
        ));
      },
      (response) {
        add(VerificationStartTimerEvent());
      },
    );
  }

  void _onVerificationSubmitEvent(
    VerificationSubmitEvent event,
    Emitter<VerificationState> emit,
  ) async {
    emit(state.copyWith(status: VerificationStatus.processing));

    final userModel = state.userModel?.copyWith(code: state.inputCode) ??
        UserModel(email: "", password: "");

    final result = await UserRepository().register(userModel);

    result.fold(
      (error) {
        emit(state.copyWith(
          status: VerificationStatus.failure,
          isShowMessageOtp: true,
          messageCode: error,
        ));
      },
      (response) {
        emit(state.copyWith(status: VerificationStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
