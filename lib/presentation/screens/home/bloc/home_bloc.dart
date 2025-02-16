import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/models/genre_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/repository/watch_list_repository.dart';
import 'package:movie_marks/data/repository/genre_repository.dart';
import 'package:movie_marks/data/repository/movie_repository.dart';
import 'package:movie_marks/data/repository/user_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GenreRepository genreRepository = GenreRepository();
  final MovieRepository movieRepository = MovieRepository();
  final UserRepository userRepository = UserRepository();
  final WatchListRepository bookmarkRepository = WatchListRepository();

  int currentPage = 1;
  bool isEndOfList = false;

  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<HomeLoadMoreMoviesEvent>(_onHomeLoadMoreMoviesEvent);
    on<HomeGenreSelectionEvent>(_onHomeGenreSelection);
    on<HomeToggleBookmarkEvent>(_onHomeToggleBookmarkEvent);
    on<HomeUpdateMovieEvent>(_onHomeUpdateMovieEvent);
  }

  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: HomeStatus.initial,
      isLoadingPage: event.isLoadingPage,
    ));

    try {
      final genresFuture = genreRepository.getListGenres();
      final moviesFuture = movieRepository.getPopularMovies();

      final userEither = await userRepository.getUserInfo();
      final user = userEither.fold(
        (error) => null,
        (response) => response,
      );

      final bookmarkEither = await movieRepository.getListMoviesBookmark();
      final bookmarks = bookmarkEither.fold<List<MovieModel>>(
        (error) {
          return [];
        },
        (response) {
          return response;
        },
      );

      final results = await Future.wait([genresFuture, moviesFuture]);

      final genres = results[0] as List<GenreModel>;
      final movies = results[1] as List<MovieModel>;

      final updatedMovies = movies.map((movie) {
        final matchingBookmark = bookmarks.firstWhere(
          (b) => b.id == movie.id,
          orElse: () => MovieModel(),
        );

        return movie.copyWith(
            isSaved: matchingBookmark.isSaved,
            isRating: matchingBookmark.isRating,
            userAverageRating: matchingBookmark.userAverageRating,
            overallAverageRating: matchingBookmark.overallAverageRating);
      }).toList();

      emit(state.copyWith(
        status: HomeStatus.success,
        isLoadingPage: event.isLoadingPage,
        listGenres: genres,
        listMovies: updatedMovies,
        listBookmark: bookmarks,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
      ));
    }
  }

  void _onHomeLoadMoreMoviesEvent(
      HomeLoadMoreMoviesEvent event, Emitter<HomeState> emit) async {
    if (isEndOfList) return;

    emit(state.copyWith(status: HomeStatus.processing));
    await Future.delayed(const Duration(seconds: 1));

    final selectedGenreIds = state.listGenres
        ?.where((genre) => genre.isSelected)
        .map((genre) => genre.id)
        .whereType<int>()
        .toList();

    try {
      final newMovies = await movieRepository
          .getMoviesByGenres(selectedGenreIds ?? [], page: currentPage + 1);

      if (newMovies.isEmpty) {
        emit(state.copyWith(
          status: HomeStatus.success,
        ));
        isEndOfList = true;
      } else {
        final updatedNewMovies = newMovies.map((movie) {
          final bookmark = state.listBookmark?.firstWhere(
            (b) => b.id == movie.id,
            orElse: () => MovieModel(),
          );

          return movie.copyWith(
              isSaved: bookmark?.isSaved,
              isRating: bookmark?.isRating,
              userAverageRating: bookmark?.userAverageRating,
              overallAverageRating: bookmark?.overallAverageRating);
        }).toList();

        currentPage++;
        emit(state.copyWith(
          listMovies: List.of(state.listMovies ?? [])..addAll(updatedNewMovies),
          status: HomeStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
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

    try {
      final movies =
          await movieRepository.getMoviesByGenres(selectedGenreIds ?? []);

      final updatedMovies = movies.map((movie) {
        final bookmark = state.listBookmark?.firstWhere(
          (b) => b.id == movie.id,
          orElse: () => MovieModel(),
        );

        return movie.copyWith(
            isSaved: bookmark?.isSaved,
            isRating: bookmark?.isRating,
            userAverageRating: bookmark?.userAverageRating,
            overallAverageRating: bookmark?.overallAverageRating);
      }).toList();

      emit(state.copyWith(listMovies: updatedMovies));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  void _onHomeToggleBookmarkEvent(
      HomeToggleBookmarkEvent event, Emitter<HomeState> emit) async {
    final result = await bookmarkRepository.toggleBookmark(
      movieModel: event.movieModel,
    );

    await result.fold(
      (error) async {
        emit(state.copyWith(status: HomeStatus.failure));
      },
      (response) async {
        final updatedBookmarks = await movieRepository.getListMoviesBookmark();

        final bookmarks = updatedBookmarks.fold<List<MovieModel>>(
          (error) => [],
          (response) => response,
        );

        final updatedMovies = state.listMovies?.map((movie) {
          final bookmark = bookmarks.firstWhere(
            (b) => b.id == movie.id,
            orElse: () => MovieModel(),
          );

          return movie.copyWith(
              isSaved: bookmark.isSaved,
              isRating: bookmark.isRating,
              userAverageRating: bookmark.userAverageRating,
              overallAverageRating: bookmark.overallAverageRating);
        }).toList();

        if (!emit.isDone) {
          emit(state.copyWith(
            listMovies: updatedMovies,
            listBookmark: bookmarks,
            status: HomeStatus.success,
          ));
        }
      },
    );
  }

  void _onHomeUpdateMovieEvent(
      HomeUpdateMovieEvent event, Emitter<HomeState> emit) {
    final updatedMovies = state.listMovies?.map((movie) {
      if (movie.id == event.movieModel.id) {
        return event.movieModel;
      }
      return movie;
    }).toList();

    emit(state.copyWith(listMovies: updatedMovies));
  }
}
