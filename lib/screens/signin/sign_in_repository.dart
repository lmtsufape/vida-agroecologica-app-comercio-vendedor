import 'dart:developer';

import 'package:flutter/material.dart';

class SignInRepository {
  Future signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email != 'teste@teste.com' &&
        password != '12345678') {
      return Future.error('Email ou senha inválidos');
    } else {
      log('Fine. Successfully signed in. Now pushing to /home screen');
      onSuccess();
    }
  }
}
