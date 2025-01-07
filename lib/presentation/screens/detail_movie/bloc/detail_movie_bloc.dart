import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/repository/movie_repository.dart';
import 'package:movie_marks/data/repository/search_repository.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MovieRepository movieRepository = MovieRepository();
  final SearchRepository searchRepository = SearchRepository();

  DetailMovieBloc() : super(DetailMovieState.initial()) {
    on<DetailMovieInitialEvent>(_onDetailMovieInitialEvent);
  }

  void _onDetailMovieInitialEvent(
      DetailMovieInitialEvent event, Emitter<DetailMovieState> emit) async {
    final movie = await movieRepository.getMovieDetail(event.movieId);
    final keywords = await searchRepository.getMovieKeywords(event.movieId);
    final externalIds =
        await movieRepository.getMovieExternalIds(event.movieId);

    emit(state.copyWith(
        status: DetailMovieStatus.success,
        isLoadingPage: event.isLoadingPage,
        movieModel: movie,
        movieId: event.movieId,
        keywords: keywords,
        externalIdsModel: externalIds));
  }
}
