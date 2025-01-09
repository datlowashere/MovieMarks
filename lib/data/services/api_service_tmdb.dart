import 'package:dio/dio.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/constants/app_secret_key.dart';

class ApiServiceTMDB {
  final Dio _dio;

  ApiServiceTMDB({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: ApiUrls.tmdbApiBaseUrl));

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      queryParameters = queryParameters ?? {};
      queryParameters['api_key'] = AppSecretKey.apiKey;

      final response = await _dio.get(path, queryParameters: queryParameters);
      print("Response url : $path");
      return response;
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
