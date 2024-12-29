import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/repository/genre_repository.dart';
import 'package:movie_marks/data/repository/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GenreRepository genreRepository = GenreRepository();
  final MovieRepository movieRepository = MovieRepository();

  int currentPage = 1;
  bool isEndOfList = false;

  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<LoadMoreMoviesEvent>(_onLoadMoreMoviesEvent);
  }
  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.processing, isLoadingPage: event.isLoadingPage));

    try {
      final genres = await genreRepository.getListGenres();
      final movies = await movieRepository.getPopularMovies();

      emit(state.copyWith(
        status: HomeStatus.success,
        isLoadingPage: event.isLoadingPage,
        listGenres: genres,
        listMovies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
  void _onLoadMoreMoviesEvent(
      LoadMoreMoviesEvent event, Emitter<HomeState> emit) async {
    if (isEndOfList) return;
    emit(state.copyWith(status: HomeStatus.processing));

    final newMovies =
        await movieRepository.getPopularMovies(page: currentPage + 1);

    if (newMovies.isEmpty) {
      isEndOfList = true;
    } else {
      currentPage++;
      emit(state.copyWith(
        listMovies: List.of(state.listMovies ?? [])..addAll(newMovies),
        status: HomeStatus.success,
      ));
    }
  }
}
