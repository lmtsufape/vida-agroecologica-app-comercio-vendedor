import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';

class SignInRepository {
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
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('id', response.data['user']['id']);
        prefs.setString('email', email);
        prefs.setString('token',
            response.data['user']['token'].toString());
        prefs.setString('name',
            response.data['user']['nome'].toString());
        onSuccess();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
