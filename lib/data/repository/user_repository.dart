import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/data/services/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<Either<String, dynamic>> login(UserModel userModel) async {
    try {
      final response = await _apiService.request(
        ApiUrls.loginEndPoint,
        method: Method.post,
        data: userModel.toJson(),
      );

      String accessToken = response.data['accessToken'];
      await SharedPrefer.sharedPrefer.setUserToken(accessToken);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> logout() async {
    try {
      final response = await _apiService.request(
        ApiUrls.logoutEndPoint,
        method: Method.post,
      );

      await SharedPrefer.sharedPrefer.setUserToken("");
      return Right(response.data['message']);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, dynamic>> sendVerificationCode(String email) async {
    try {
      final data = {"email": email};

      final response = await _apiService.request(ApiUrls.sendCodeEndPoint,
          method: Method.post, data: data);
      print("object: ${response.data}");
      return Right(response.data);
    } catch (e) {
      print("Error: $e");
      return Left(e.toString());
    }
  }

  Future<Either<String, Response>> register(UserModel userModel) async {
    try {
      final response = await _apiService.request(ApiUrls.registerEndPoint,
          method: Method.post, data: userModel.registerToJson());

      if (response.statusCode == 201) {
        await login(userModel);
        return Right(response);
      } else {
        return Left('${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
