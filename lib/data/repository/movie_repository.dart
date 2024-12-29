import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/services/api_service_tmdb.dart';

class MovieRepository {
  final ApiServiceTMDB _apiService;

  MovieRepository({ApiServiceTMDB? apiService})
      : _apiService = apiService ?? ApiServiceTMDB();

  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await _apiService.get(ApiUrls.moviesEndPoint, queryParameters: {
      'page': page,
    });

    final movies = (response.data['results'] as List<dynamic>)
        .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return movies;
  }
}
