import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thunderapp/shared/constants/app_enums.dart';

class SignUpController extends GetxController {
  int _infoIndex = 0;
  ScreenState screenState = ScreenState.idle;

  String? _errorMessage = '';
  final TextEditingController _nomeController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _telefoneController =
      TextEditingController();
  final TextEditingController _cepController =
      TextEditingController();
  final TextEditingController _ruaController =
      TextEditingController();
  final TextEditingController _numeroController =
      TextEditingController();
  final TextEditingController _bairroController =
      TextEditingController();

  TextEditingController get nomeController =>
      _nomeController;
  TextEditingController get emailController =>
      _emailController;
  TextEditingController get passwordController =>
      _passwordController;
  TextEditingController get telefoneController =>
      _telefoneController;
  TextEditingController get cepController => _cepController;
  TextEditingController get ruaController => _ruaController;
  TextEditingController get numeroController =>
      _numeroController;
  TextEditingController get bairroController =>
      _bairroController;
  String? get errorMessage => _errorMessage;
  int get infoIndex => _infoIndex;

  void next() {
    _infoIndex++;
    update();
  }

  void back() {
    _infoIndex--;
    update();
  }

  void getBairros() {}
}
