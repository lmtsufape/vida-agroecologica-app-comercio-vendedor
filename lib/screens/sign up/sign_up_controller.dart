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
  List<BairroModel> bairros = [];
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

  void loadBairros() async {
    bairros = await signUpRepository.getbairros();
  }

  @override
  void onInit() {
    loadBairros();
    super.onInit();
  }
}
