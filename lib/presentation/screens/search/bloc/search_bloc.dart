import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/repository/search_repository.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_event.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository = SearchRepository();

  SearchBloc() : super(SearchState.initial()) {
    on<SearchInitialEvent>(_onSearchInitialEvent);
    on<SearchValueChangedEvent>(_onSearchValueChangedEvent);
    on<SearchLoadMoreEvent>(_onSearchLoadMoreEvent);
  }

  void _onSearchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.initial));
  }

  void _onSearchValueChangedEvent(
      SearchValueChangedEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(searchValue: event.searchValue));

    final searchResult = await searchRepository.searchMovies(event.searchValue);
    emit(state.copyWith(
        searchModel: searchResult, searchValue: event.searchValue));
  }

  void _onSearchLoadMoreEvent(
      SearchLoadMoreEvent event, Emitter<SearchState> emit) async {
    if (state.isLoadingMore ||
        state.searchModel?.page == state.searchModel?.totalPages) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, status: SearchStatus.processing));

    try {
      final nextPage = (state.searchModel?.page ?? 0) + 1;
      final searchResult = await searchRepository
          .searchMovies(state.searchValue ?? "", page: nextPage);

      final updatedMovies = [
        ...?state.searchModel?.movies,
        ...?searchResult.movies,
      ];

      emit(state.copyWith(
          isLoadingMore: false,
          searchModel: state.searchModel?.copyWith(
            page: searchResult.page,
            movies: updatedMovies,
            totalPages: searchResult.totalPages,
            totalResults: searchResult.totalResults,
          ),
          status: SearchStatus.success));
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, status: SearchStatus.failure));
    }
  }
}
