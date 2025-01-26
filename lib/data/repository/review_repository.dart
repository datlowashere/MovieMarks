import 'package:dartz/dartz.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/review_data_model.dart';
import 'package:movie_marks/data/models/review_model.dart';
import 'package:movie_marks/data/services/api_service.dart';

class ReviewRepository {
  final ApiService _apiService = ApiService();

  Future<Either<String, ReviewModel>> createReview(
      ReviewModel reviewModel) async {
    try {
      final response = await _apiService.request(
        ApiUrls.reviewEndPoint,
        method: Method.post,
        data: reviewModel.postToJson(),
      );

      final review = ReviewModel.fromJson(response.data['review']);

      return Right(review);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ReviewDataModel>> getReviewsById(String id) async {
    try {
      final response = await _apiService.request(
        '${ApiUrls.reviewEndPoint}/$id',
        method: Method.get,
      );

      final reviewData = ReviewDataModel.fromJson(response.data);

      return Right(reviewData);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
