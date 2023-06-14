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
        '$kBaseURL/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['user']['papel'].toString() ==
            'Produtor') {
          log('User é um produtor');
          if (await userStorage.userHasCredentials()) {
            await userStorage.clearUserCredentials();
          }
          await userStorage.saveUserCredentials(
              id: response.data['user']['id'].toString(),
              nome:
                  response.data['user']['nome'].toString(),
              token:
                  response.data['user']['token'].toString(),
              email:
                  response.data['user']['email'].toString(),
              papel:
                  response.data['user']['papel'].toString(),
              papelId: response.data['user']['papel_id']
                  .toString());
          return true;
        } else {
          return false;

          //Colocar caixa de erro aqui
        }
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }
}
