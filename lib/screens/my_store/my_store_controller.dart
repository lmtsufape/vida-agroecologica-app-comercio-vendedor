// ignore_for_file: avoid_print
import 'dart:convert';
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
  final List<String?> horariosAbertura = List.filled(7, null);
  final List<String?> horariosFechamento = List.filled(7, null);

  // Lista de dias da semana
  final List<String> diasSemana = [
    'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
  ];
  
  // Estados dos dias selecionados (todos começam como falso)
  final List<bool> diasSelecionados = List.generate(7, (_) => false);

  // Método para alternar a seleção de um dia específico
  void toggleDiaSemana(int index) {
    diasSelecionados[index] = !diasSelecionados[index];
    update();
  }

  void definirHorarioDia(int index, String abertura, String fechamento) {
    diasSelecionados[index] = true;
    horariosAbertura[index] = abertura;
    horariosFechamento[index] = fechamento;
    update();
  }

  // Método para verificar se pelo menos um dia foi selecionado
  bool temDiaSelecionado() {
    return diasSelecionados.contains(true);
  }

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

  Future<void> saveDiasFuncionamento() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, List<String>> diasFuncionamentoMap = {};
  
  // Mapeamento dos nomes de dias para o formato esperado pela API
  final Map<String, String> formatoDiasSemana = {
    'Segunda': 'segunda-feira',
    'Terça': 'terca-feira',
    'Quarta': 'quarta-feira',
    'Quinta': 'quinta-feira',
    'Sexta': 'sexta-feira',
    'Sábado': 'sábado',
    'Domingo': 'domingo'
  };
  
  log("Estado atual dos dias selecionados: $diasSelecionados");
  
  for (int i = 0; i < diasSelecionados.length; i++) {
    if (diasSelecionados[i]) {
      // Use o formato correto do dia e adicione os horários específicos deste dia
      String diaFormatado = formatoDiasSemana[diasSemana[i]] ?? diasSemana[i].toLowerCase();
      
      // Usar horários específicos do dia ou valores padrão
      String horarioAbertura = horariosAbertura[i] ?? horarioAberturaController.text;
      String horarioFechamento = horariosFechamento[i] ?? horarioFechamentoController.text;
      
      diasFuncionamentoMap[diaFormatado] = [
        horarioAbertura,
        horarioFechamento
      ];
      
      log("Dia adicionado: ${diasSemana[i]} => $diaFormatado: [$horarioAbertura, $horarioFechamento]");
    }
  }
  
  // Converte o mapa para formato JSON
  String diasJson = jsonEncode(diasFuncionamentoMap);
  await prefs.setString('dias_funcionamento_banca', diasJson);
  
  // Verificar se o valor foi salvo corretamente
  String? savedValue = prefs.getString('dias_funcionamento_banca');
  log("Valor salvo em SharedPreferences: $savedValue");
  
  log("Dias de funcionamento salvos localmente no formato correto");
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
      // Primeiro, salvar os dias de funcionamento no SharedPreferences
      await saveDiasFuncionamento();
      
      // A lista de dias pode ainda ser útil para o log ou outras operações
      List<String> diasFuncionamento = [];
      for (int i = 0; i < diasSelecionados.length; i++) {
        if (diasSelecionados[i]) {
          diasFuncionamento.add(diasSemana[i]);
        }
      }
      
      print("Dias selecionados: ${diasFuncionamento.join(', ')}");
      
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
        diasFuncionamento // Mantendo para compatibilidade
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
    if (!verifyFields()) {
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
      // Mostrar um indicador de progresso
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      
      // Primeiro salvar os dias de funcionamento
      await saveDiasFuncionamento();
      
      // Log dos dias selecionados
      List<String> diasFuncionamento = [];
      for (int i = 0; i < diasSelecionados.length; i++) {
        if (diasSelecionados[i]) {
          diasFuncionamento.add(diasSemana[i]);
        }
      }
      log("Dias selecionados: ${diasFuncionamento.join(', ')}");
      
      // Chamar o método adicionarBancaJson do repository
      adcSucess = await myStoreRepository.adicionarBancaJson(
        _nomeBancaController.text,
        _horarioAberturaController.text,
        _horarioFechamentoController.text,
        _quantiaMinController.text,
        _imagePath,
        isSelected,
        deliver,
        _pixController.text,
      );

      // Fechar o indicador de progresso
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

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
        showDialog(
          context: context,
          builder: (context) => DefaultAlertDialogOneButton(
            title: 'Erro',
            body: 'Não foi possível criar a banca. Tente novamente.',
            confirmText: 'Ok',
            onConfirm: () => Navigator.pop(context),
            buttonColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Fechar o indicador de progresso em caso de erro
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      
      log("Erro detalhado: $e");
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
  int boolPagamento = 0;

  if (pixBool == false && cashBool == false) {
    boolPagamento = 1;
  } else {
    boolPagamento = 0;
  }

  // Verificar se tem pelo menos um dia selecionado COM horários definidos
  bool temHorarioDefinido = false;
  for (int i = 0; i < diasSelecionados.length; i++) {
    if (diasSelecionados[i] && 
        horariosAbertura[i] != null && 
        horariosFechamento[i] != null) {
      temHorarioDefinido = true;
      break;
    }
  }

  if (_nomeBancaController.text.isEmpty) {
    textoErro = "Insira o nome da banca.";
    return false;
  }

  if (imagePath == null) {
    textoErro = "Insira uma imagem.";
    return false;
  }

  if (boolPagamento == 1) {
    textoErro = "Selecione ao menos uma forma de pagamento.";
    return false;
  }

  if (pixBool == true && _pixController.text.isEmpty) {
    textoErro = "Insira uma chave PIX.";
    return false;
  }

  if (!temDiaSelecionado()) {
    textoErro = "Selecione pelo menos um dia de funcionamento.";
    return false;
  }

  if (!temHorarioDefinido) {
    textoErro = "Defina os horários de funcionamento para os dias selecionados.";
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
        _horarioFechamentoController.text.isEmpty || 
        boolPagamento == 1 ||
        !temDiaSelecionado()) {
      
      if (pixBool == true && _pixController.text.isEmpty) {
        textoErro = "Insira uma chave PIX.";
        return false;
      }
      else if(boolPagamento == 1){
        textoErro = "Selecione ao menos uma forma de pagamento.";
        return false;
      }
      else if(!temDiaSelecionado()){
        textoErro = "Selecione pelo menos um dia de funcionamento.";
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