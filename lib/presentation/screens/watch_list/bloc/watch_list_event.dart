import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/movie_model.dart';

sealed class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object?> get props => [];
}

final class WatchListInitialEvent extends WatchListEvent {}

final class WatchListLoadMoreEvent extends WatchListEvent {}

final class WatchListDeleteMovieEvent extends WatchListEvent {
  final int idMovie;

  const WatchListDeleteMovieEvent({required this.idMovie});

  @override
  List<Object?> get props => [idMovie];
}

class WatchListUpdateMovieEvent extends WatchListEvent {
  final MovieModel movieModel;

  const WatchListUpdateMovieEvent(this.movieModel);

  @override
  List<Object?> get props => [movieModel];
}