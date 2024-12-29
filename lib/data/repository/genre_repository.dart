import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/genre_model.dart';
import 'package:movie_marks/data/services/api_service_tmdb.dart';

class GenreRepository {
  final ApiServiceTMDB _apiService;

  GenreRepository({ApiServiceTMDB? apiService})
      : _apiService = apiService ?? ApiServiceTMDB();

  Future<List<GenreModel>> getListGenres() async {
    final response = await _apiService.get(ApiUrls.genreEndPoint);

    final genres = (response.data['genres'] as List<dynamic>)
        .map((json) => GenreModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return genres;
  }
}
