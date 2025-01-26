import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/repository/bookmark_repository.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_event.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final BookmarkRepository bookmarkRepository = BookmarkRepository();

  int currentPage = 1;
  final int limit = 10;

  WatchListBloc() : super(const WatchListState()) {
    on<WatchListInitialEvent>(_onWatchListInitialEvent);
    on<WatchListLoadMoreEvent>(_onWatchListLoadMoreEvent);
    on<WatchListDeleteMovieEvent>(_onWatchListDeleteMovieEvent);
    on<WatchListUpdateMovieEvent>(_onWatchListUpdateMovieEvent);
  }

  Future<void> _onWatchListInitialEvent(
    WatchListInitialEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(state.copyWith(
      status: WatchListStatus.processing,
    ));
    final watchListEither = await bookmarkRepository.getBookmarksByUser();

    watchListEither.fold((error) {
      emit(state.copyWith(status: WatchListStatus.failure));
    }, (response) {
      emit(state.copyWith(
          status: WatchListStatus.success, listMovies: response));
    });
  }

  Future<void> _onWatchListLoadMoreEvent(
    WatchListLoadMoreEvent event,
    Emitter<WatchListState> emit,
  ) async {
    if (state.status == WatchListStatus.processing) {
      return;
    }

    emit(state.copyWith(status: WatchListStatus.processing));
    currentPage++;

    final watchListEither = await bookmarkRepository.getBookmarksByUser(
        page: currentPage, limit: limit);

    watchListEither.fold((error) {
      emit(state.copyWith(status: WatchListStatus.failure));
    }, (response) {
      final updatedMoviesList =
          List<MovieModel>.from(state.listMovies as Iterable)..addAll(response);

      emit(state.copyWith(
        status: WatchListStatus.success,
        listMovies: updatedMoviesList,
      ));
    });
  }

  void _onWatchListDeleteMovieEvent(
    WatchListDeleteMovieEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(state.copyWith(status: WatchListStatus.processing));

    final watchListEither =
        await bookmarkRepository.deleteBookmark(event.idMovie);

    watchListEither.fold((error) {
      emit(state.copyWith(status: WatchListStatus.failure));
    }, (response) {
      final updatedMoviesList = state.listMovies
          ?.where((movie) => movie.id != event.idMovie)
          .toList();

      emit(state.copyWith(
        status: WatchListStatus.success,
        listMovies: updatedMoviesList,
      ));
    });
  }

  void _onWatchListUpdateMovieEvent(
      WatchListUpdateMovieEvent event, Emitter<WatchListState> emit) {
    final updatedMovies = state.listMovies?.map((movie) {
      if (movie.id == event.movieModel.id) {
        return event.movieModel;
      }
      return movie;
    }).where((movie) {
      return movie.isSaved == true;
    }).toList();

    emit(state.copyWith(listMovies: updatedMovies));
  }
}
