// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class SignInRepository {
  final userStorage = UserStorage();
  String userId = "0";
  String userToken = "0";
  String noAut = 'Você não possui autorização, fale com o Presidente da associação';

  final _dio = Dio();

  Future<int> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$kBaseURL/sanctum/token',
        data: {'email': email, 'password': password, 'device_name': "PC"},
      );
      if (response.statusCode == 200) {
        if (await userStorage.userHasCredentials()) {
          await userStorage.clearUserCredentials();
        }
        userId = response.data['user']['id'].toString();
        userToken = response.data['token'].toString();
        await userStorage.saveUserCredentials(
          id: userId,
          nome: response.data['user']['name'].toString(),
          token: userToken,
          email: response.data['user']['email'].toString(),
        );
        try {
          Response response = await _dio.get(
            '$kBaseURL/bancas/agricultores/$userId',
            options: Options(headers: {"Authorization": "Bearer $userToken"}),
          );
          Response userResponse = await _dio.get(
            '$kBaseURL/users/$userId',
            options: Options(headers: {"Authorization": "Bearer $userToken"}),
          );
          if (response.statusCode == 200) {
            List roles = userResponse.data['user']['roles'];
            if (roles.isNotEmpty) {
              bool hasRole4 = roles.any((role) => role['id'] == 4);
              print('Role ID: $hasRole4');
              if(roles.contains(4)){}
              if (response.data["bancas"].isEmpty) {
                if (hasRole4) {
                  return 2;
                } else {
                  print(noAut);
                  return 3;
                }
              } else if (hasRole4) {
                print(response.statusCode);
                return 1;
              } else {
                print(noAut);
                return 3;
              }
            }
          }
        } catch (e) {
          print(e);
          return 0;
        }
        return 1;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
    return 0;
  }
}
