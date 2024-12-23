import 'package:bloc/bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<MainInitialEvent>(_onMainInitialEvent);
  }

  void _onMainInitialEvent(
      MainInitialEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(
        status: MainStatus.processing, isLoadingPage: event.isLoadingPage));
  }
}
