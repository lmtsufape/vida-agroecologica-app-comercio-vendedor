// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/my_store/my_store_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import '../../assets/index.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/style_constants.dart';
import '../../shared/core/image_picker_controller.dart';
import '../home/home_screen.dart';
import '../screens_index.dart';
import 'package:path_provider/path_provider.dart';

class MyStoreController extends GetxController {
  UserStorage userStorage = UserStorage();
  MyStoreRepository myStoreRepository = MyStoreRepository();
  HomeScreenRepository homeScreenRepository = HomeScreenRepository();
  BancaModel? bancaModel;
  final _imagePickerController = ImagePickerController();

  File? _selectedImage;
  String? _imagePath;
  NetworkImage? imagemStore;

  bool hasImg = false;
  bool editSucess = false;
  bool adcSucess = false;
  var textoErro = "Verifique os campos";
  String? userId;
  String? userToken;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<bool> isSelected = [false, false, false];
  final List<String> checkItems = ['Dinheiro', 'PIX', 'Cartão'];
  final List<bool> delivery = [false, false];
  final List<String> deliveryItems = ['Sim', 'Não'];

  bool deliver = false;
  bool pixBool = false;
  bool cashBool = false;

  String? get imagePath => _imagePath;

  set imagePath(String? value) {
    _imagePath = value;
    update();
  }

  File? get selectedImage => _selectedImage;

  set selectedImage(File? value) {
    _selectedImage = value;
    update();
  }

  MaskTextInputFormatter timeFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter timeFormatter2 = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final TextEditingController _nomeBancaController = TextEditingController();
  final TextEditingController _pixController = TextEditingController();
  final TextEditingController _quantiaMinController = TextEditingController();
  final TextEditingController _horarioAberturaController =
      TextEditingController();
  final TextEditingController _horarioFechamentoController =
      TextEditingController();

  TextEditingController get nomeBancaController => _nomeBancaController;

  TextEditingController get quantiaMinController => _quantiaMinController;

  TextEditingController get pixController => _pixController;

  TextEditingController get horarioAberturaController =>
      _horarioAberturaController;

  TextEditingController get horarioFechamentoController =>
      _horarioFechamentoController;

  void onItemTapped(int index) {
    isSelected[index] = !isSelected[index];
    update();
  }

  Future getBancaPrefs() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    userId = (await userStorage.getUserId());
    userToken = await userStorage.getUserToken();
    bancaModel = await homeScreenRepository.getBancaPrefs(
        userToken, userId);
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

  Future<NetworkImage?> getImageStore(int id) async {
    imagemStore = await myStoreRepository.getImageStore(id);
    return imagemStore;
  }


  void setDeliver(bool value) {
    deliver = value;
    update();
  }

  void setPixBool(bool value) {
    pixBool = value;
    update();
  }
  void setCashBool(bool value) {
    cashBool = value;
    update();
  }

  bool checkImg() {
    if (_selectedImage == null) {
      return false;
    }
    return true;
  }

  Future<File> _getAssetAsFile(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    Directory? tempDir;
    try {
      tempDir = await getTemporaryDirectory(); // Pode lançar erro
    } catch (e) {
      print("Erro ao acessar getTemporaryDirectory: $e");
    }

    // Se getTemporaryDirectory() falhar, usa getApplicationDocumentsDirectory()
    tempDir ??= await getApplicationDocumentsDirectory();

    final tempFile = File('${tempDir.path}/default_image.png');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile;
  }

  Future<void> selectImageCam() async {
    try {
      File? file = await _imagePickerController.pickImageFromCamera();
      if (file != null) {
        imagePath = file.path;
        selectedImage = file;
        _selectedImage = selectedImage;
      }
      update(); // Atualiza a UI apenas se uma nova imagem for selecionada
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> selectImage() async {
    try {
      File? file = await _imagePickerController.pickImageFromGallery();
      if (file != null) {
        imagePath = file.path;
        selectedImage = file;
        _selectedImage = selectedImage;
      }
      update(); // Atualiza a UI apenas se uma nova imagem for selecionada
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String errorMessage) {
    Get.dialog(
      AlertDialog(
        title: const Text('Erro'),
        content: Text("$errorMessage\n Procure o suporte com a equipe LMTS"),
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


  Future clearImg() async {
    _selectedImage = null;
    update();
  }

  void editBanca(BuildContext context, BancaModel banca) async {
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
        print("Edição bem-sucedida. Navegando para HomeScreen...");
        Get.back();
        Future.delayed(Duration(milliseconds: 200), () {
          Get.offAll(() => const HomeScreen());
        });
      } else {
        print("Edição falhou. Nenhuma navegação executada.");
      }
    } catch (e, stackTrace) {
      print("Erro ao tentar editar banca: $e");
      print("Stack trace: $stackTrace");

      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content: Text(
              "Ocorreu um erro ao editar a banca. Por favor, tente novamente. \nERRO: ${e.toString()} \nSTACKTRACE: $stackTrace"),
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
    if (!verifyFields()) { // Removida a verificação _imagePath == null
      textoErro = "Verifique os campos obrigatórios.";
      showDialog(
        context: context,
        builder: (context) => DefaultAlertDialogOneButton(
          title: 'Erro',
          body: textoErro,
          confirmText: 'Ok',
          onConfirm: () => Get.back(),
          buttonColor: Colors.red,
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
        _imagePath, // Pode ser null, o repositório trata isso
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
            onConfirm: () => Navigator.pushReplacementNamed(context, Screens.home),
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
          content: Text("Erro: ${e.toString()}\nEntre em contato com o suporte."),
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
      textoErro = "Selecione ao menos uma forma de pagamento.";
      return false;
    }
  }

  bool verifyFields() {
    bool hasPaymentMethod = isSelected.contains(true);
    int boolPagamento = 0;

    if(pixBool == false && cashBool == false){
      boolPagamento = 1;
    }
    else{
      boolPagamento = 0;
    }

    if (_nomeBancaController.text.isEmpty ||
        _horarioAberturaController.text.isEmpty ||
        _horarioFechamentoController.text.isEmpty || imagePath == null || boolPagamento == 1) {
      if (pixBool == true && _pixController.text.isEmpty) {
        textoErro = "Insira uma chave PIX.";
        return false;
      }
      else if(boolPagamento == 1 && imagePath == null){
        textoErro = "Insira uma imagem e Selecione ao menos uma forma de pagamento.";
        return false;
      }
      else if(imagePath == null){
        textoErro = "Insira uma imagem.";
        return false;
      }
      else if(boolPagamento == 1){
        textoErro = "Selecione ao menos uma forma de pagamento.";
        return false;
      }
        textoErro = "Verifique os campos obrigatórios.";
        return false;
    }
    return true;
  }

  bool verifyFieldsEdit() {
    bool hasPaymentMethod = isSelected.contains(true);
    int boolPagamento = 0;

    if(pixBool == false && cashBool == false){
      boolPagamento = 1;
    }
    else{
      boolPagamento = 0;
    }

    if (_nomeBancaController.text.isEmpty ||
        _horarioAberturaController.text.isEmpty ||
        _horarioFechamentoController.text.isEmpty || boolPagamento == 1) {
      if (pixBool == true && _pixController.text.isEmpty) {
        textoErro = "Insira uma chave PIX.";
        return false;
      }
      else if(boolPagamento == 1 && imagePath == null){
        textoErro = "Insira uma imagem e Selecione ao menos uma forma de pagamento.";
        return false;
      }
      else if(boolPagamento == 1){
        textoErro = "Selecione ao menos uma forma de pagamento.";
        return false;
      }
      textoErro = "Verifique os campos obrigatórios.";
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBancaPrefs();
    update();
  }

}
