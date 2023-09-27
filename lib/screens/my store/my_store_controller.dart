import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thunderapp/screens/my%20store/my_store_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../../shared/core/image_picker_controller.dart';
import '../screens_index.dart';

class MyStoreController extends GetxController {
  UserStorage userStorage = UserStorage();
  MyStoreRepository myStoreRepository = MyStoreRepository();
  File? _selectedImage;
  final _imagePickerController = ImagePickerController();
  String? _imagePath;
  bool hasImg = false;
  bool editSucess = false;
  bool adcSucess = false;
  String userToken = '';

  final List<bool> isSelected = [false, false, false];
  final List<String> checkItems = ['Dinheiro', 'PIX', 'Cartão'];

  bool deliver = false;

  MaskTextInputFormatter timeFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);


final TextEditingController _nomeBancaController = TextEditingController();
final TextEditingController _quantiaMinController = TextEditingController();
final TextEditingController _horarioAberturaController =
TextEditingController();
final TextEditingController _horarioFechamentoController =
TextEditingController();

TextEditingController get nomeBancaController => _nomeBancaController;

TextEditingController get quantiaMinController => _quantiaMinController;

TextEditingController get horarioAberturaController =>
    _horarioAberturaController;

TextEditingController get horarioFechamentoController =>
    _horarioFechamentoController;

void onItemTapped(int index) {
  isSelected[index] = !isSelected[index];
  update();
}

void setDeliver(bool value) {
  deliver = value;
  update();
}

bool checkImg() {
  if (_selectedImage == null) {
    return false;
  }
  return true;
}

String? get imagePath => _imagePath;

File? get selectedImage => _selectedImage;

set selectedImage(File? value) {
  _selectedImage = value;
  update();
}

Future selectImageCam() async {
  File? file = await _imagePickerController.pickImageFromCamera();
  if (file != null) {
    _imagePath = file.path;
  } else {
    return null;
  }

  _selectedImage = file;

  update();
}

Future selectImage() async {
  File? file = await _imagePickerController.pickImageFromGalery();
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

void editBanca(BuildContext context, BancaModel banca) async {
  editSucess = await myStoreRepository.editarBanca(
      _nomeBancaController.text,
      _horarioAberturaController.text,
      _horarioFechamentoController.text,
      _quantiaMinController.text,
      _imagePath,
      isSelected,
      banca);
  if (editSucess) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Screens.home);
  }
}

void adicionarBanca(BuildContext context) async {
  try {
    adcSucess = await myStoreRepository.adicionarBanca(
        _nomeBancaController.text,
        _horarioAberturaController.text,
        _horarioFechamentoController.text,
        _quantiaMinController.text,
        _imagePath,
        isSelected);
    if (adcSucess) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Screens.home);
    } else {
      log("ocorreu um erro, verifique os campos e tente novamente");
    }
  } catch (e) {
    print(e);
  }
}

bool verifySelectedFields() {
  if (_quantiaMinController.text.isNotEmpty) {
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        return true;
      }
    }
  }

  return false;
}

bool verifyFields() {
  if (_nomeBancaController.text.isNotEmpty &&
      _horarioAberturaController.text.isNotEmpty &&
      _horarioFechamentoController.text.isNotEmpty &&
      _quantiaMinController.text.isNotEmpty &&
      _imagePath != null) {
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        return true;
      }
    }
    return false;
  }
  return false;
}}
