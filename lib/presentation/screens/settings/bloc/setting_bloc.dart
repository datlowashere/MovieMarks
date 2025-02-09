import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_event.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserRepository userRepository = UserRepository();

  SettingBloc() : super(SettingState.initial()) {
    on<SettingInitialEvent>(_onSettingInitialEvent);
    on<SettingGetUserProfileEvent>(_onSettingGetUserProfileEvent);
    on<SettingLogoutEvent>(_onSettingLogoutEvent);
  }

  void _onSettingInitialEvent(
      SettingInitialEvent event, Emitter<SettingState> emit) async {
    add(SettingGetUserProfileEvent());
  }

  void _onSettingGetUserProfileEvent(
      SettingGetUserProfileEvent event, Emitter<SettingState> emit) async {
    final result = await userRepository.getUserInfo();
    result.fold((error) {}, (response) {
      emit(state.copyWith(user: response));
    });
  }

  void _onSettingLogoutEvent(
      SettingLogoutEvent event, Emitter<SettingState> emit) async {
    emit(state.copyWith(status: SettingStatus.processing));
    final result = await userRepository.logout();
    result.fold(
      (error) {
        emit(state.copyWith(status: SettingStatus.failure));
      },
      (response) {
        emit(state.copyWith(
            status: SettingStatus.success,
            user: UserModel(email: "", password: "")));
      },
    );
  }
}
