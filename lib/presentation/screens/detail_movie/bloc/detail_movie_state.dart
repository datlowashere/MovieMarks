import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/movie_model.dart';

enum DetailMovieStatus {
  initial,
  processing,
  success,
  failure,
}

final class DetailMovieState extends Equatable {
  final DetailMovieStatus? status;
  final bool isLoadingPage;
  final MovieModel? movieModel;

  const DetailMovieState({
    this.status,
    this.isLoadingPage = false,
    this.movieModel,
  });

  static DetailMovieState initial() => const DetailMovieState(
        status: DetailMovieStatus.initial,
      );

  DetailMovieState copyWith(
      {DetailMovieStatus? status,
      bool? isLoadingPage,
      MovieModel? movieModel}) {
    return DetailMovieState(
        status: status ?? this.status,
        isLoadingPage: isLoadingPage ?? this.isLoadingPage,
        movieModel: movieModel ?? this.movieModel);
  }

  @override
  List<Object?> get props => [status, isLoadingPage, movieModel];
}
