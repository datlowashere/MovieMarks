import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/external_ids_model.dart';
import 'package:movie_marks/data/models/keyword_model.dart';
import 'package:movie_marks/data/models/movie_credits_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/models/review_data_model.dart';

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
  final int? movieId;
  final List<KeywordModel>? keywords;
  final ExternalIdsModel? externalIdsModel;
  final MovieCreditsModel? movieCreditsModel;
  final ReviewDataModel? reviewData;
  final double? ratePoint;
  final String? inputReview;

  const DetailMovieState({
    this.status,
    this.isLoadingPage = false,
    this.movieModel,
    this.movieId,
    this.keywords,
    this.externalIdsModel,
    this.movieCreditsModel,
    this.reviewData,
    this.ratePoint,
    this.inputReview,
  });

  static DetailMovieState initial() => const DetailMovieState(
        status: DetailMovieStatus.initial,
      );

  DetailMovieState copyWith({
    DetailMovieStatus? status,
    bool? isLoadingPage,
    MovieModel? movieModel,
    int? movieId,
    List<KeywordModel>? keywords,
    ExternalIdsModel? externalIdsModel,
    MovieCreditsModel? movieCreditsModel,
    ReviewDataModel? reviewData,
    double? ratePoint,
    String? inputReview,
  }) {
    return DetailMovieState(
        status: status ?? this.status,
        isLoadingPage: isLoadingPage ?? this.isLoadingPage,
        movieModel: movieModel ?? this.movieModel,
        movieId: movieId ?? this.movieId,
        keywords: keywords ?? this.keywords,
        externalIdsModel: externalIdsModel ?? this.externalIdsModel,
        movieCreditsModel: movieCreditsModel ?? this.movieCreditsModel,
        reviewData: reviewData ?? this.reviewData,
        ratePoint: ratePoint ?? this.ratePoint,
        inputReview: inputReview ?? this.inputReview);
  }

  @override
  List<Object?> get props => [
        status,
        isLoadingPage,
        movieModel,
        movieId,
        keywords,
        externalIdsModel,
        movieCreditsModel,
        reviewData,
        ratePoint,
        inputReview
      ];
}
