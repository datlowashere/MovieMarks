import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
  }

  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        status: HomeStatus.processing, isLoadingPage: event.isLoadingPage));
  }
}
