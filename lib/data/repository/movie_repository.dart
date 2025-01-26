import 'package:dartz/dartz.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/external_ids_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/services/api_service.dart';
import 'package:movie_marks/data/services/api_service_tmdb.dart';

class MovieRepository {
  final ApiServiceTMDB _apiTMDBService;
  final ApiService _apiService = ApiService();

  MovieRepository({ApiServiceTMDB? apiService})
      : _apiTMDBService = apiService ?? ApiServiceTMDB();

  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response =
        await _apiTMDBService.get(ApiUrls.moviesEndPoint, queryParameters: {
      'page': page,
    });

    final movies = (response.data['results'] as List<dynamic>)
        .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return movies;
  }

  Future<List<MovieModel>> getMoviesByGenres(List<int> genreIds,
      {int page = 1}) async {
    final response = await _apiTMDBService
        .get(ApiUrls.filterByGenreEndPoint, queryParameters: {
      'with_genres': genreIds.join(','),
      'page': page,
    });

    final movies = (response.data['results'] as List<dynamic>)
        .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return movies;
  }

  Future<MovieModel> getMovieDetail(int movieId) async {
    final response = await _apiTMDBService.get(
      '${ApiUrls.movieEndPoint}$movieId',
    );

    final movieDetail =
        MovieModel.fromJson(response.data as Map<String, dynamic>);
    return movieDetail;
  }

  Future<ExternalIdsModel> getMovieExternalIds(int movieId) async {
    final response = await _apiTMDBService
        .get("${ApiUrls.movieEndPoint}$movieId${ApiUrls.externalIdEndPoint}");

    final externalIds =
        ExternalIdsModel.fromJson(response.data as Map<String, dynamic>);
    return externalIds;
  }

  Future<Either<String, List<MovieModel>>> getListMoviesBookmark() async {
    try {
      final response = await _apiService.request(
        ApiUrls.bookmarkEndPoint,
        method: Method.get,
      );

      final movies = (response.data['bookmarks'] as List<dynamic>)
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(movies);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
