import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_repository.dart';

import 'package:thunderapp/shared/constants/app_enums.dart';

import '../../shared/core/image_picker_controller.dart';
import '../../shared/core/models/bairro_model.dart';

class SignUpController extends GetxController {
  int _infoIndex = 0;
  int bairroId = 0;
  double strength = 0;
  bool? signupSuccess;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Z].*");
  String displayText = 'Digite sua Senha';
  final _imagePickerController = ImagePickerController();
  File? _selectedImage;
  final List<bool> isSelected = [false, false];
  final List<String> checkItems = ['Dinheiro', 'PIX'];
  bool deliver = false;

  String? _imagePath;
  bool hasImg = false;

  void setDeliver(bool value) {
    deliver = value;
    update();
  }

  ///List<BairroModel> bairros = [];
  ScreenState screenState = ScreenState.idle;
  final SignUpRepository signUpRepository =
      SignUpRepository();
  String? _errorMessage = '';

  MaskTextInputFormatter phoneFormatter =
      MaskTextInputFormatter(
          mask: '(##) #####-####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter cepFormatter =
      MaskTextInputFormatter(
          mask: '#####-###',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter cpfFormatter =
      MaskTextInputFormatter(
          mask: '###.###.###-##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);

  final TextEditingController _nomeController =
      TextEditingController();
  final TextEditingController _apelidoController =
      TextEditingController();
  final TextEditingController _cpfController =
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
  TextEditingController get apelidoController =>
      _apelidoController;
  TextEditingController get cpfController => _cpfController;
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

  bool checkImg() {
    if (_selectedImage == null) {
      return false;
    }
    return true;
  }

  bool? get signupSucess => signupSuccess;

  String? get imagePath => _imagePath;

  File? get selectedImage => _selectedImage;

  //Esse setter é responsável por setar a imagem selecionada e atualizar a tela,
  set selectedImage(File? value) {
    _selectedImage = value;
    update();
  }

  //Essa função é responsável por pegar a imagem da câmera e setar o caminho da imagem,
  Future selectImageCam() async {
    File? file =
        await _imagePickerController.pickImageFromCamera();
    if (file != null) {
      _imagePath = file.path;
    } else {
      return null;
    }

    _selectedImage = file;

    update();
  }

  //Essa função é responsável por pegar a imagem da galeria e setar o caminho da imagem,
  Future selectImage() async {
    File? file =
        await _imagePickerController.pickImageFromGalery();
    if (file != null) {
      _imagePath = file.path;
    } else {
      return null;
    }

    _selectedImage = file;
    update();
  }

  Future clearImg() async {
    _selectedImage = null;
    update();
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

  void signUp(BuildContext context) async {
    log(signupSuccess.toString());
    signupSuccess = await signUpRepository.signUp(
        _nomeController.text,
        _emailController.text,
        _passwordController.text,
        _apelidoController.text,
        _telefoneController.text,
        _cpfController.text,
        _ruaController.text,
        _bairroController.text,
        _numeroController.text,
        _cepController.text,
        _nomeBancaController.text,
        _horarioAberturaController.text,
        _horarioFechamentoController.text,
        _quantiaMinController.text,
        deliver,
        _imagePath,
        isSelected,
        context);
    update();
    log(signupSuccess.toString());
  }

  bool validateEmptyFields() {
    if (_nomeController.text.isEmpty ||
        _apelidoController.text.isEmpty ||
        _cpfController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _cepController.text.isEmpty ||
        _ruaController.text.isEmpty ||
        _numeroController.text.isEmpty ||
        _bairroController.text.isEmpty ||
        _nomeBancaController.text.isEmpty ||
        _quantiaMinController.text.isEmpty ||
        _horarioAberturaController.text.isEmpty ||
        _horarioFechamentoController.text.isEmpty ||
        _imagePath == null) {
      log('Error, o user não preencheu todos os campos, retornando falso');
      return false;
    }

    return true;
  }

  bool validateEmail() {
    if (_emailController.text.contains('@') &&
        _emailController.text.contains('.com')) {
      return true;
    }
    log('Error no cadastro de email, retornando falso');
    return false;
  }

  bool validateNumber() {
    if (_numeroController.text.length <= 4 &&
        _numeroController.text.contains(RegExp(r'[0-9]'))) {
      return true;
    }
    log('Error no cadastro de número, retornando falso');
    return false;
  }
}
