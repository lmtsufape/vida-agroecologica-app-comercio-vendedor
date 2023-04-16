import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class SignInRepository {
  final userStorage = UserStorage();

  final _dio = Dio();
  Future signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
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
          userStorage.saveUserCredentials(
            id: response.data['user']['id'].toString(),
            nome: response.data['user']['nome'].toString(),
            token:
                response.data['user']['token'].toString(),
            email:
                response.data['user']['email'].toString(),
            papel:
                response.data['user']['papel'].toString(),
          );
          onSuccess();
        } else {
          log('User não é um produtor');
          //Colocar caixa de erro aqui
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
