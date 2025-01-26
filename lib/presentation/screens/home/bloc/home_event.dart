import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/genre_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class HomeInitialEvent extends HomeEvent {
  final bool isLoadingPage;

  const HomeInitialEvent({required this.isLoadingPage});

  @override
  List<Object?> get props => [];
}

final class HomeLoadMoreMoviesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

final class HomeGenreSelectionEvent extends HomeEvent {
  final GenreModel genre;

  const HomeGenreSelectionEvent(this.genre);

  @override
  List<Object?> get props => [genre];
}

final class HomeToggleBookmarkEvent extends HomeEvent {
  final MovieModel movieModel;

  const HomeToggleBookmarkEvent(this.movieModel);

  @override
  List<Object?> get props => [movieModel];
}

class HomeUpdateMovieEvent extends HomeEvent {
  final MovieModel movieModel;

  const HomeUpdateMovieEvent(this.movieModel);

  @override
  List<Object?> get props => [movieModel];
}

