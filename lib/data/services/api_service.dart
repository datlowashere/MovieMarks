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

  // void _handleError(DioException e) {
  //   final responseData = e.response?.data;
  //   switch (e.type) {
  //     case DioExceptionType.connectionTimeout:
  //       throw "Connection Timeout";
  //     case DioExceptionType.sendTimeout:
  //       throw "Send Timeout";
  //     case DioExceptionType.receiveTimeout:
  //       throw "Receive Timeout";
  //     case DioExceptionType.badResponse:
  //       final errorMessage = responseData is Map<String, dynamic> &&
  //               responseData.containsKey('message')
  //           ? responseData['message']
  //           : "Unexpected error occurred (${e.response?.statusCode})";
  //       throw errorMessage;
  //     case DioExceptionType.cancel:
  //       throw "Request Cancelled";
  //     case DioExceptionType.unknown:
  //       throw "Unknown Error: ${e.message}";
  //     default:
  //       throw "Unexpected Dio Error: ${e.message}";
  //   }
  // }

  void _handleError(DioException e) {
    // In tất cả các thông tin về lỗi
    print("DioException caught:");
    print("- Type: ${e.type}");
    print("- Message: ${e.message}");
    print("- Response: ${e.response?.toString() ?? "No response"}");
    print("- Headers: ${e.response?.headers}");
    print("- Data: ${e.response?.data}");

    final responseData = e.response?.data;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw "Connection Timeout: Unable to connect to the server.";
      case DioExceptionType.sendTimeout:
        throw "Send Timeout: The server did not receive the request in time.";
      case DioExceptionType.receiveTimeout:
        throw "Receive Timeout: The server took too long to respond.";
      case DioExceptionType.badResponse:
        final errorMessage = responseData is Map<String, dynamic> &&
            responseData.containsKey('message')
            ? responseData['message']
            : "Unexpected error occurred with status code ${e.response?.statusCode}";
        throw errorMessage;
      case DioExceptionType.cancel:
        throw "Request Cancelled.";
      case DioExceptionType.unknown:
        throw "Unknown Error: ${e.message}";
      default:
        throw "Unexpected Dio Error: ${e.message}";
    }
  }

}
