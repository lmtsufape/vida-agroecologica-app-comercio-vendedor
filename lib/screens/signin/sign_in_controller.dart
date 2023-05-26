import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/screens/screens_index.dart';

import 'sign_in_repository.dart';

enum SignInStatus {
  done,
  error,
  loading,
  idle,
}

class SignInController with ChangeNotifier {
  final SignInRepository _repository = SignInRepository();
  String? email;
  String? password;
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  String? errorMessage;

  TextEditingController get emailController =>
      _emailController;
  TextEditingController get passwordController =>
      _passwordController;
  var status = SignInStatus.idle;
  void signIn(BuildContext context) async {
    try {
      status = SignInStatus.loading;
      notifyListeners();

      var succ = await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (succ == true) {
        status = SignInStatus.done;
        notifyListeners();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
            context, Screens.home);
      }
      if (!succ) {
        status = SignInStatus.error;
        setErrorMessage(
            'Credenciais inválidas, verifique seus dados');
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      status = SignInStatus.error;
      setErrorMessage(
          'Credenciais inválidas verifique seus dados');
      notifyListeners();
    }
  }

  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    errorMessage = null;
    notifyListeners();
  }
}
