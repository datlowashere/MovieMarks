import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/models/review_model.dart';

sealed class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

final class DetailMovieInitialEvent extends DetailMovieEvent {
  final bool isLoadingPage;
  final int movieId;
  final bool isSaved;

  const DetailMovieInitialEvent({
    required this.isLoadingPage,
    required this.movieId,
    required this.isSaved,
  });

  @override
  List<Object?> get props => [isLoadingPage, movieId, isSaved];
}

final class DetailMovieReviewChangedEvent extends DetailMovieEvent {
  final String review;

  const DetailMovieReviewChangedEvent({required this.review});

  @override
  List<Object?> get props => [review];
}

final class DetailMovieRateEvent extends DetailMovieEvent {
  final double ratePoint;

  const DetailMovieRateEvent({required this.ratePoint});

  @override
  List<Object?> get props => [ratePoint];
}

final class DetailMovieSubmitRateEvent extends DetailMovieEvent {
  @override
  List<Object?> get props => [];
}

final class DetailMovieToggleBookmarkEvent extends DetailMovieEvent {
  final MovieModel movieModel;
  final List<ReviewModel> reviews;

  const DetailMovieToggleBookmarkEvent(this.movieModel, this.reviews);

  @override
  List<Object?> get props => [movieModel, reviews];
}

final class DetailMovieBackEvent extends DetailMovieEvent {
  final MovieModel movieModel;
  final List<ReviewModel> reviews;

  const DetailMovieBackEvent(this.movieModel, this.reviews);

  @override
  List<Object?> get props => [movieModel, reviews];
}
