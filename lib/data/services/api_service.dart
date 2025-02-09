import 'package:dio/dio.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';

enum Method { get, post, put, delete, patch }

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    var accessToken = SharedPrefer.sharedPrefer.getUserToken();
    _dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        if (accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
      },
      contentType: 'application/json',
      responseType: ResponseType.json,
    );
  }
  Future<Response> request(
      String endpoint, {
        required Method method,
        Map<String, dynamic>? params,
        dynamic data,
        Map<String, String>? headers,
        Options? options,
      }) async {
    try {
      if (data is FormData) {
        headers ??= {};
        headers['Content-Type'] = 'multipart/form-data';
      }

      Options requestOptions = options?.copyWith(
        method: _getMethodString(method),
        headers: {..._dio.options.headers, ...?headers},
      ) ??
          Options(
            method: _getMethodString(method),
            headers: {..._dio.options.headers, ...?headers},
          );

      Response response = await _dio.request(
        endpoint,
        queryParameters: params,
        data: data,
        options: requestOptions,
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
    final responseData = e.response?.data;
    final statusCode = e.response?.statusCode;

    String errorMessage = "Unexpected error ($statusCode)";

    if (responseData is Map<String, dynamic>) {
      errorMessage = responseData.containsKey('message')
          ? responseData['message']
          : "Error: ${responseData.toString()}";
    } else if (responseData != null) {
      errorMessage = "Error Response: ${responseData.toString()}";
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw "Connection Timeout";
      case DioExceptionType.sendTimeout:
        throw "Send Timeout";
      case DioExceptionType.receiveTimeout:
        throw "Receive Timeout";
      case DioExceptionType.badResponse:
        throw errorMessage;
      case DioExceptionType.cancel:
        throw "Request Cancelled";
      case DioExceptionType.unknown:
        throw "Unknown Error: ${e.message}";
      default:
        throw "Unexpected Dio Error: ${e.message}";
    }
  }

}
