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
    on<HomeLoadMoreMoviesEvent>(_onHomeLoadMoreMoviesEvent);
    on<HomeGenreSelectionEvent>(_onHomeGenreSelection);
  }

  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        status: HomeStatus.processing, isLoadingPage: event.isLoadingPage));

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

  void _onHomeLoadMoreMoviesEvent(
      HomeLoadMoreMoviesEvent event, Emitter<HomeState> emit) async {
    if (isEndOfList) return;
    emit(state.copyWith(status: HomeStatus.processing));

    final selectedGenreIds = state.listGenres
        ?.where((genre) => genre.isSelected)
        .map((genre) => genre.id)
        .whereType<int>()
        .toList();

    final newMovies = await movieRepository
        .getMoviesByGenres(selectedGenreIds ?? [], page: currentPage + 1);

    if (newMovies.isEmpty) {
      emit(state.copyWith(
        status: HomeStatus.success,
      ));
      isEndOfList = true;
    } else {
      currentPage++;
      emit(state.copyWith(
        listMovies: List.of(state.listMovies ?? [])..addAll(newMovies),
        status: HomeStatus.success,
      ));
    }
  }

  void _onHomeGenreSelection(
      HomeGenreSelectionEvent event, Emitter<HomeState> emit) async {
    final updatedGenres = state.listGenres?.map((genre) {
      if (genre.id == event.genre.id) {
        return genre.copyWith(isSelected: !genre.isSelected);
      }
      return genre;
    }).toList();

    emit(state.copyWith(listGenres: updatedGenres));

    final selectedGenreIds = updatedGenres
        ?.where((genre) => genre.isSelected)
        .map((genre) => genre.id)
        .whereType<int>()
        .toList();

    final movies =
        await movieRepository.getMoviesByGenres(selectedGenreIds ?? []);

    emit(state.copyWith(listMovies: movies));
  }
}
