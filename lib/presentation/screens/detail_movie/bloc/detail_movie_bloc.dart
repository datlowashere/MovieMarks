import 'package:bloc/bloc.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/data/models/review_data_model.dart';
import 'package:movie_marks/data/models/review_model.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/repository/cast_crew_repository.dart';
import 'package:movie_marks/data/repository/movie_repository.dart';
import 'package:movie_marks/data/repository/review_repository.dart';
import 'package:movie_marks/data/repository/search_repository.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MovieRepository movieRepository = MovieRepository();
  final SearchRepository searchRepository = SearchRepository();
  final CastCrewRepository castCrewRepository = CastCrewRepository();
  final ReviewRepository reviewRepository = ReviewRepository();

  DetailMovieBloc() : super(DetailMovieState.initial()) {
    on<DetailMovieInitialEvent>(_onDetailMovieInitialEvent);
    on<DetailMovieReviewChangedEvent>(_onDetailMovieReviewChangedEvent);
    on<DetailMovieRateEvent>(_onDetailMovieRateEvent);
    on<DetailMovieSubmitRateEvent>(_onDetailMovieSubmitRateEvent);
  }

  void _onDetailMovieInitialEvent(
      DetailMovieInitialEvent event, Emitter<DetailMovieState> emit) async {
    emit(state.copyWith(
      status: DetailMovieStatus.processing,
      isLoadingPage: event.isLoadingPage,
    ));

    try {
      final movie = await movieRepository.getMovieDetail(event.movieId);
      final keywords = await searchRepository.getMovieKeywords(event.movieId);
      final externalIds =
          await movieRepository.getMovieExternalIds(event.movieId);
      final movieCredits =
          await castCrewRepository.getListCastAndCrew(event.movieId);

      final reviewEither =
          await reviewRepository.getReviewsById(event.movieId.toString());
      final reviewData = reviewEither.fold(
        (error) {
          final emptyReview = ReviewDataModel(averageRating: "0", reviews: []);
          return emptyReview;
        },
        (response) {
          return response;
        },
      );
      print("id: ${event.movieId}");

      print("reviewData: ${reviewData}");

      emit(state.copyWith(
          status: DetailMovieStatus.success,
          isLoadingPage: event.isLoadingPage,
          movieModel: movie,
          movieId: event.movieId,
          keywords: keywords,
          externalIdsModel: externalIds,
          movieCreditsModel: movieCredits,
          reviewData: reviewData));
    } catch (error) {
      emit(state.copyWith(
        status: DetailMovieStatus.failure,
        isLoadingPage: event.isLoadingPage,
      ));
    }
  }

  void _onDetailMovieReviewChangedEvent(
      DetailMovieReviewChangedEvent event, Emitter<DetailMovieState> emit) {
    emit(state.copyWith(inputReview: event.review));
  }

  void _onDetailMovieRateEvent(
      DetailMovieRateEvent event, Emitter<DetailMovieState> emit) {
    emit(state.copyWith(ratePoint: event.ratePoint));
  }

  void _onDetailMovieSubmitRateEvent(
      DetailMovieSubmitRateEvent event, Emitter<DetailMovieState> emit) async {
    final userId = SharedPrefer.sharedPrefer.getUserId();
    final userAvatar = SharedPrefer.sharedPrefer.getAvatar();
    final username = SharedPrefer.sharedPrefer.getUsername();

    final review = ReviewModel(
        movieId: state.movieId.toString(),
        userId: userId,
        content: state.inputReview,
        ratingPoint: state.ratePoint);

    final userInfo = UserModel(
        email: "", password: '', username: username, avatar: userAvatar);

    final result = await reviewRepository.createReview(review);
    result.fold((error) {}, (response) {
      final existingReviewData = state.reviewData;

      final updatedReviews = [
        response.copyWith(user: userInfo),
        if (existingReviewData?.reviews != null) ...existingReviewData!.reviews,
      ];

      final updatedReviewData = existingReviewData?.copyWith(
              reviews: updatedReviews,
              averageRating:
                  calculateNewAverageRating(updatedReviews).toString()) ??
          ReviewDataModel(
            reviews: [response],
            averageRating: "${calculateNewAverageRating(updatedReviews)}",
          );

      emit(state.copyWith(reviewData: updatedReviewData));
    });
  }

  double calculateNewAverageRating(List<ReviewModel> reviews) {
    final totalRating = reviews.fold<double>(
      0.0,
      (sum, review) => sum + (review.ratingPoint ?? 0.0),
    );
    final average = reviews.isNotEmpty ? totalRating / reviews.length : 0.0;
    return double.parse(average.toStringAsFixed(2));
  }
}
