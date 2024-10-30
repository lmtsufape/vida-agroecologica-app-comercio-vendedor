// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thunderapp/screens/my_store/my_store_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/style_constants.dart';
import '../../shared/core/image_picker_controller.dart';
import '../home/home_screen.dart';
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
  var textoErro = "Verifique os campos";
  String userToken = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<bool> isSelected = [false, false, false];
  final List<String> checkItems = [
    'Dinheiro',
    'PIX',
    'Cartão'
  ];
  final List<bool> delivery = [false, false];
  final List<String> deliveryItems = ['Sim', 'Não'];

  bool deliver = false;
  bool pixBool = false;
  MaskTextInputFormatter timeFormatter =
      MaskTextInputFormatter(
          mask: '##:##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter timeFormatter2 =
      MaskTextInputFormatter(
          mask: '##:##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);

  final TextEditingController _nomeBancaController =
      TextEditingController();
  final TextEditingController _pixController =
      TextEditingController();
  final TextEditingController _quantiaMinController =
      TextEditingController();
  final TextEditingController _horarioAberturaController =
      TextEditingController();
  final TextEditingController _horarioFechamentoController =
      TextEditingController();

  TextEditingController get nomeBancaController =>
      _nomeBancaController;
  TextEditingController get quantiaMinController =>
      _quantiaMinController;
  TextEditingController get pixController => _pixController;
  TextEditingController get horarioAberturaController =>
      _horarioAberturaController;
  TextEditingController get horarioFechamentoController =>
      _horarioFechamentoController;

  void onItemTapped(int index) {
    isSelected[index] = !isSelected[index];
    update();
  }

  void onDeliveryTapped(int index) {
    for (int i = 0; i < delivery.length; i++) {
      delivery[i] = false;
    }
    delivery[index] = true;
    deliver = delivery[0];
    update();
  }

  String role() {
    return myStoreRepository.role;
  }

  void setDeliver(bool value) {
    deliver = value;
    update();
  }

  void setPixBool(bool value) {
    pixBool = value;
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
    try {
      File? file = await _imagePickerController
          .pickImageFromCamera();
      if (file != null) {
        _imagePath = file.path;
      } else {
        return null;
      }
      _selectedImage = file;
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Erro 1'),
          content: Text(
              "${e.toString()}\n Procure o suporte com a equipe LMTS"),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }

    update();
  }

  Future selectImage() async {
    try {
      File? file = await _imagePickerController
          .pickImageFromGallery();
      if (file != null) {
        _imagePath = file.path;
      } else {
        return null;
      }

      _selectedImage = file;
      update();
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content: Text(
              "${e.toString()}\n Procure o suporte com a equipe LMTS"),
          actions: [
            TextButton(
              child: const Text('Voltar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  Future clearImg() async {
    _selectedImage = null;
    update();
  }

  void editBanca(
      BuildContext context, BancaModel banca) async {
    try {
      editSucess = await myStoreRepository.editarBanca(
        _nomeBancaController.text,
        _horarioAberturaController.text,
        _horarioFechamentoController.text,
        _quantiaMinController.text,
        _imagePath,
        isSelected,
        _pixController.text,
        deliver,
        banca,
      );

      if (editSucess) {
        print(
            "Edição bem-sucedida. Navegando para HomeScreen...");
        Get.back();
        Future.delayed(Duration(milliseconds: 200), () {
          Get.offAll(() => const HomeScreen());
        });
      } else {
        print(
            "Edição falhou. Nenhuma navegação executada.");
      }
    } catch (e, stackTrace) {
      print("Erro ao tentar editar banca: $e");
      print("Stack trace: $stackTrace");

      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content: Text(
              "Ocorreu um erro ao editar a banca. Por favor, tente novamente."),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }

  void adicionarBanca(BuildContext context) async {
    if (!verifyFields() || _imagePath == null) {
      textoErro = "Verifique os campos obrigatórios.";
      showDialog(
        context: context,
        builder: (context) => DefaultAlertDialogOneButton(
          title: 'Sucesso',
          body: 'Sua banca foi criada!',
          confirmText: 'Ok',
          onConfirm: () {
            Get.back();
            Navigator.pushReplacementNamed(
                context, Screens.home);
          },
          buttonColor: kSuccessColor,
        ),
      );

      return;
    }

    try {
      adcSucess = await myStoreRepository.adicionarBanca(
        _nomeBancaController.text,
        _horarioAberturaController.text,
        _horarioFechamentoController.text,
        _quantiaMinController.text,
        _imagePath!,
        isSelected,
        deliver,
        _pixController.text,
      );
      if (adcSucess) {
        showDialog(
          context: context,
          builder: (context) => DefaultAlertDialogOneButton(
            title: 'Sucesso',
            body: 'Sua banca foi criada!',
            confirmText: 'Ok',
            onConfirm: () => Navigator.pushReplacementNamed(
                context, Screens.home),
            buttonColor: kSuccessColor,
          ),
        );
      } else {
        log("Erro ao criar banca.");
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content: Text(
              "Erro: ${e.toString()}\nEntre em contato com o suporte."),
          actions: [
            TextButton(
              child: const Text('Voltar'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }

  bool verifySelectedFields() {
    if (_nomeBancaController.text.isNotEmpty &&
        _horarioAberturaController.text.isNotEmpty &&
        _horarioFechamentoController.text.isNotEmpty &&
        isSelected.contains(true)) {
      return true;
    } else {
      textoErro =
          "Selecione ao menos uma forma de pagamento.";
      return false;
    }
  }

  bool verifyFields() {
    if (_nomeBancaController.text.isNotEmpty &&
        _horarioAberturaController.text.isNotEmpty &&
        _horarioFechamentoController.text.isNotEmpty) {
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i] == true) {
          return true;
        }
      }
    }
    return false;
  }
}
