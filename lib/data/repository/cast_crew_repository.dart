import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/movie_credits_model.dart';
import 'package:movie_marks/data/services/api_service_tmdb.dart';

class CastCrewRepository {
  final ApiServiceTMDB _apiService;

  CastCrewRepository({ApiServiceTMDB? apiService})
      : _apiService = apiService ?? ApiServiceTMDB();

  Future<MovieCreditsModel> getListCastAndCrew(int movieId) async {
    final response = await _apiService
        .get("${ApiUrls.movieEndPoint}$movieId${ApiUrls.creditEndpoint}");

    return MovieCreditsModel.fromJson(response.data);
  }
}
