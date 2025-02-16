import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/repository/watch_list_repository.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_event.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchListRepository bookmarkRepository = WatchListRepository();
  int currentPage = 1;
  final int limit = 10;

  WatchListBloc() : super(WatchListState.initial()) {
    on<WatchListInitialEvent>(_onWatchListInitialEvent);
    on<WatchListLoadMoreEvent>(_onWatchListLoadMoreEvent);
    on<WatchListDeleteMovieEvent>(_onWatchListDeleteMovieEvent);
    on<WatchListUpdateMovieEvent>(_onWatchListUpdateMovieEvent);
  }

  void _onWatchListInitialEvent(
      WatchListInitialEvent event, Emitter<WatchListState> emit) async {
    emit(state.copyWith(status: WatchListStatus.processing));
    await Future.delayed(const Duration(seconds: 1));

    final watchListEither = await bookmarkRepository.getWatchListByUser();

    watchListEither.fold(
      (error) {
        emit(state.copyWith(status: WatchListStatus.failure));
      },
      (watchList) {
        currentPage = watchList.pagination.currentPage;
        emit(state.copyWith(
          status: WatchListStatus.success,
          watchListModel: watchList,
        ));
      },
    );
  }

  void _onWatchListLoadMoreEvent(
      WatchListLoadMoreEvent event, Emitter<WatchListState> emit) async {
    if (state.status == WatchListStatus.processing ||
        state.watchListModel == null) return;

    final currentWatchList = state.watchListModel;
    final totalPages = currentWatchList?.pagination.totalPages ?? 1;

    if (currentPage >= totalPages) {
      return;
    }

    emit(state.copyWith(status: WatchListStatus.processing));

    await Future.delayed(const Duration(seconds: 1));

    currentPage++;

    final watchListEither = await bookmarkRepository.getWatchListByUser(
      page: currentPage,
      limit: limit,
    );

    watchListEither.fold(
      (error) => emit(state.copyWith(status: WatchListStatus.failure)),
      (watchList) {
        final updatedMovies = <MovieModel>[
          ...(currentWatchList?.movieModel ?? []),
          ...watchList.movieModel
        ];
        final updatedWatchList = currentWatchList?.copyWith(
          movieModel: updatedMovies,
          pagination: watchList.pagination,
        );

        emit(state.copyWith(
          status: WatchListStatus.success,
          watchListModel: updatedWatchList,
        ));
      },
    );
  }

  void _onWatchListDeleteMovieEvent(
      WatchListDeleteMovieEvent event, Emitter<WatchListState> emit) async {
    if (state.watchListModel == null) return;

    emit(state.copyWith(status: WatchListStatus.processing));

    final deleteEither = await bookmarkRepository.deleteBookmark(event.idMovie);

    deleteEither.fold(
      (error) => emit(state.copyWith(status: WatchListStatus.failure)),
      (_) {
        final updatedMovies = state.watchListModel!.movieModel
            .where((movie) => movie.id != event.idMovie)
            .toList();
        final updatedWatchList =
            state.watchListModel!.copyWith(movieModel: updatedMovies);

        emit(state.copyWith(
          status: WatchListStatus.success,
          watchListModel: updatedWatchList,
        ));
      },
    );
  }

  void _onWatchListUpdateMovieEvent(
      WatchListUpdateMovieEvent event, Emitter<WatchListState> emit) {
    if (state.watchListModel == null) return;

    final updatedMovies = state.watchListModel!.movieModel
        .map((movie) {
          return movie.id == event.movieModel.id ? event.movieModel : movie;
        })
        .where((movie) => movie.isSaved)
        .toList();

    final updatedWatchList =
        state.watchListModel!.copyWith(movieModel: updatedMovies);

    emit(state.copyWith(watchListModel: updatedWatchList));
  }
}
