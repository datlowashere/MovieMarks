import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
      await SharedPrefer.sharedPrefer.setUserId("");
      await SharedPrefer.sharedPrefer.setAvatar("");
      await SharedPrefer.sharedPrefer.setUsername("");
      await SharedPrefer.sharedPrefer.setEmailUser("");

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
      return Right(response.data);
    } catch (e) {
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

  Future<Either<String, UserModel>> getUserInfo() async {
    try {
      final response = await _apiService.request(
        ApiUrls.getUserEndPoint,
        method: Method.get,
      );
      final avatarUrl = response.data['user']['avatar'] as String?;
      final id = response.data['user']['_id'] as String?;
      final username = response.data['user']['username'] as String?;
      final email = response.data['user']['email'] as String?;

      if (avatarUrl != null && avatarUrl.isNotEmpty) {
        await SharedPrefer.sharedPrefer.setAvatar(avatarUrl);
      }
      if (id != null && id.isNotEmpty) {
        await SharedPrefer.sharedPrefer.setUserId(id);
      }
      if (username != null && username.isNotEmpty) {
        await SharedPrefer.sharedPrefer.setUsername(username);
      }
      if (email != null && email.isNotEmpty) {
        await SharedPrefer.sharedPrefer.setEmailUser(email);
      }
      final user = UserModel.fromJson(response.data['user']);

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> editUserProfile(
      UserModel? user, File? avatarFile) async {
    try {
      FormData formData = FormData.fromMap(user?.editToJson() ?? {});

      if (avatarFile != null) {
        formData.files.add(
          MapEntry(
            'avatar',
            await MultipartFile.fromFile(
              avatarFile.path,
              filename: avatarFile.path.split('/').last,
              contentType: MediaType('image', 'png'),
            ),
          ),
        );
      }

      final response = await _apiService.request(
        ApiUrls.updateUser,
        method: Method.put,
        data: formData,
      );

      if (response.statusCode == 200 && response.data != null) {
        UserModel updatedUser = UserModel.fromJson(response.data);
        return Right(updatedUser);
      } else {
        return Left(" ${response.statusMessage}");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
