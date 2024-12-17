import 'package:dio/dio.dart';
import 'package:movie_marks/constants/api_urls.dart';

enum Method { get, post, put, delete, patch }

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // var accessToken = SharedPrefer.sharedPrefer.getUserToken();
    var accessToken = "";

    _dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        if (accessToken.isNotEmpty) 'Authorization': accessToken,
      },
      contentType: 'application/json',
      responseType: ResponseType.json,
    );
  }

  Future<Response> request(
    String endpoint, {
    required Method method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      Options options = Options(
        method: _getMethodString(method),
        headers: headers,
      );

      Response response = await _dio.request(
        endpoint,
        queryParameters: params,
        data: data,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      _handleError(e);
      throw Exception("Request failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  String _getMethodString(Method method) {
    switch (method) {
      case Method.get:
        return 'GET';
      case Method.post:
        return 'POST';
      case Method.put:
        return 'PUT';
      case Method.delete:
        return 'DELETE';
      case Method.patch:
        return 'PATCH';
    }
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception("Connection Timeout");
      case DioExceptionType.sendTimeout:
        throw Exception("Send Timeout");
      case DioExceptionType.receiveTimeout:
        throw Exception("Receive Timeout");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        switch (statusCode) {
          case 401:
            throw Exception("Unauthorized: $responseData");
          case 403:
            throw Exception("Forbidden: $responseData");
          case 404:
            throw Exception("Not Found: $responseData");
          case 500:
            throw Exception("Internal Server Error: $responseData");
          default:
            throw Exception("HTTP Error ($statusCode): $responseData");
        }
      case DioExceptionType.cancel:
        throw Exception("Request Cancelled");
      case DioExceptionType.unknown:
        throw Exception("Unknown Error: ${e.message}");
      default:
        throw Exception("Unexpected Dio Error: ${e.message}");
    }
  }
}
