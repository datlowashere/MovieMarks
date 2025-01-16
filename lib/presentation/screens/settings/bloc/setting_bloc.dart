import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_event.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState.initial()) {
    on<SettingInitialEvent>(_onSettingInitialEvent);
    on<SettingLogoutEvent>(_onSettingLogoutEvent);
  }

  void _onSettingInitialEvent(
      SettingInitialEvent event, Emitter<SettingState> emit) {}

  void _onSettingLogoutEvent(
      SettingLogoutEvent event, Emitter<SettingState> emit) async {
    emit(state.copyWith(status: SettingStatus.processing));
    final result = await UserRepository().logout();
    result.fold(
      (err) {
        emit(state.copyWith(status: SettingStatus.failure));
      },
      (response) {
        emit(state.copyWith(
          status: SettingStatus.success,
          // userModel: userModel,
        ));
      },
    );
  }
}
