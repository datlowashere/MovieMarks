import 'package:bloc/bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc() : super(DetailMovieState.initial()) {
    on<DetailMovieInitialEvent>(_onDetailMovieInitialEvent);
  }

  void _onDetailMovieInitialEvent(
      DetailMovieInitialEvent event, Emitter<DetailMovieState> emit) async {
    emit(state.copyWith(
        status: DetailMovieStatus.success,
        isLoadingPage: event.isLoadingPage,
        movieModel: event.movieModel));
  }
}
