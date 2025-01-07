import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/keyword_model.dart';
import 'package:movie_marks/data/services/api_service_tmdb.dart';

class SearchRepository {
  final ApiServiceTMDB _apiService;

  SearchRepository({ApiServiceTMDB? apiService})
      : _apiService = apiService ?? ApiServiceTMDB();

  Future<List<KeywordModel>> getMovieKeywords(int movieId) async {
    final response = await _apiService.get("${ApiUrls.movieEndPoint}$movieId${ApiUrls.keywordEndPoint}");

    final keywords = (response.data['keywords'] as List<dynamic>)
        .map((json) => KeywordModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return keywords;
  }
}
