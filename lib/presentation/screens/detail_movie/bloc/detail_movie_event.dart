import 'package:equatable/equatable.dart';

sealed class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

final class DetailMovieInitialEvent extends DetailMovieEvent {
  final bool isLoadingPage;
  final int movieId;

  const DetailMovieInitialEvent({
    required this.isLoadingPage,
    required this.movieId,
  });

  @override
  List<Object?> get props => [];
}

final class DetailMovieReviewChangedEvent extends DetailMovieEvent {
  final String review;

  const DetailMovieReviewChangedEvent({required this.review});

  @override
  List<Object?> get props => [];
}

final class DetailMovieRateEvent extends DetailMovieEvent {
  final double ratePoint;

  const DetailMovieRateEvent({required this.ratePoint});

  @override
  List<Object?> get props => [];
}

final class DetailMovieSubmitRateEvent extends DetailMovieEvent {
  @override
  List<Object?> get props => [];
}
