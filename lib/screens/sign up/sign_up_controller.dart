import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_repository.dart';

import 'package:thunderapp/shared/constants/app_enums.dart';

import '../../shared/core/models/bairro_model.dart';

class SignUpController extends GetxController {
  int _infoIndex = 0;
  int bairroId = 0;
  double strength = 0;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Z].*");
  String displayText = 'Digite sua Senha';

  ///List<BairroModel> bairros = [];
  ScreenState screenState = ScreenState.idle;
  final SignUpRepository signUpRepository =
      SignUpRepository();
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
  final TextEditingController _nomeBancaController =
      TextEditingController();
  final TextEditingController _quantiaMinController =
      TextEditingController();
  final TextEditingController _horarioAberturaController =
      TextEditingController();
  final TextEditingController _horarioFechamentoController =
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
  TextEditingController get nomeBancaController =>
      _nomeBancaController;
  TextEditingController get quantiaMinController =>
      _quantiaMinController;
  TextEditingController get horarioAberturaController =>
      _horarioAberturaController;
  TextEditingController get horarioFechamentoController =>
      _horarioFechamentoController;

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

  // void loadBairros() async {
  //   bairros = await signUpRepository.getbairros();
  // }

  @override
  void onInit() {
    // loadBairros();
    super.onInit();
  }

  checkPasswordStrength(String password) {
    password = password.trim();
    if (password.isEmpty) {
      strength = 0;
      displayText = 'Digite sua Senha';
    } else if (password.length <= 6) {
      strength = 1 / 4;
      displayText = 'Senha muito fraca';
    } else if (password.length <= 8) {
      strength = 2 / 4;
      displayText = 'Senha fraca';
    } else if (numReg.hasMatch(password) &&
        letterReg.hasMatch(password)) {
      strength = 1;
      displayText = 'Senha muito forte';
    } else {
      strength = 3 / 4;
      displayText = 'Senha forte';
    }

    update();
  }
}
