import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/models/watch_list_model.dart';
import 'package:movie_marks/data/services/api_service.dart';

class WatchListRepository {
  final ApiService _apiService = ApiService();

  Future<Either<String,WatchListModel>> getWatchListByUser(
      {int page = 1, int limit = 10}) async {
    try {
      final response = await _apiService.request(
        "${ApiUrls.bookmarkEndPoint}/list?page=$page&limit=$limit",
        method: Method.get,
      );

      if (response.statusCode == 200) {
        final watchListModel = WatchListModel.fromJson(response.data);

        return Right(watchListModel);
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, Response>> addBookmark(MovieModel movieModel) async {
    try {
      final response = await _apiService.request(ApiUrls.addBookmarkEndPoint,
          method: Method.post, data: movieModel.bookmarkToJson());

      if (response.statusCode == 201) {
        return Right(response);
      } else {
        return Left('${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Response>> deleteBookmark(int idMovie) async {
    try {
      final response = await _apiService.request(
          "${ApiUrls.bookmarkEndPoint}/$idMovie/delete",
          method: Method.delete);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left('${response.data}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Response>> toggleBookmark({
    required MovieModel movieModel,
  }) async {
    if (movieModel.isSaved) {
      return await deleteBookmark(movieModel.id ?? 0);
    } else {
      return await addBookmark(movieModel);
    }
  }
}
