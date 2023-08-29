import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class SignInRepository {
  final userStorage = UserStorage();

  final _dio = Dio();
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$kBaseURL/sanctum/token',
        data: {
          'email': email,
          'password': password,
          'device_name': "PC"
        },
      );
      if (response.statusCode == 200) {
          if (await userStorage.userHasCredentials()) {
            await userStorage.clearUserCredentials();
          }
          await userStorage.saveUserCredentials(
              id: response.data['user']['id'].toString(),
              nome:
                  response.data['user']['name'].toString(),
              token:
                  response.data['token'].toString(),
              email:
                  response.data['user']['email'].toString(),
              );
          return true;
        
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }
}
