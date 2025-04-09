// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/orders/orders_repository.dart';
import 'package:thunderapp/screens/orders/orders_screen.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import 'package:thunderapp/shared/core/models/produto_pedido_model.dart';
import 'package:thunderapp/shared/core/models/user_model.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/style_constants.dart';
import '../../shared/core/user_storage.dart';
import '../home/home_screen.dart';

class OrdersController extends GetxController {
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  RxString statusOrder = ''.obs;
  int quantPedidos = 0;
  BancaModel? bancaModel;
  PedidoModel? pedidoModel;
  HomeScreenRepository homeRepository = HomeScreenRepository();
  List<PedidoModel> testePedidos = [];
  List<PedidoModel> orders = [];
  List<OrderCard> pedidos = [];
  late Future<List<dynamic>> orderData;
  OrdersRepository repository = OrdersRepository();
  bool confirmSucess = false;
  bool confirmedOrder = false;
  bool delivery = false;
  Rx<User> user = User().obs;
  File? _comprovante;
  String? _comprovanteType;
  String? _pdfPath;
  String? _downloadPath;
  Uint8List? _comprovanteBytes;
  var listaPedidos;

  File? get comprovante => _comprovante;

  String? get comprovanteType => _comprovanteType;

  String? get pdfPath => _pdfPath;

  String? get downloadPath => _downloadPath;

  Uint8List? get comprovanteBytes => _comprovanteBytes;

  List<PedidoModel> get getOrders => orders;

  void setConfirm(bool value) {
    confirmedOrder = value;
    update();
  }

  void setStatus(String value) {
    statusOrder.value = value;
    update();
  }

  void confirmOrder(BuildContext context, int id) async {
    try {
      confirmSucess = await repository.confirmOrder(id, confirmedOrder);
      if (confirmSucess && confirmedOrder == true) {
        showDialog(
            context: context,
            builder: (context) => DefaultAlertDialogOneButton(
                  title: 'Sucesso',
                  body: 'O pedido foi aceito',
                  confirmText: 'Ok',
                  onConfirm: () {
                    // navigator?.pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const HomeScreen()),
                    //   (Route<dynamic> route) => false,
                    // );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const OrdersScreen()),
                    );
                  },
                  buttonColor: kSuccessColor,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => DefaultAlertDialogOneButton(
                  title: 'Sucesso',
                  body: 'O pedido foi negado',
                  confirmText: 'Ok',
                  onConfirm: () {
                    navigator?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>const OrdersScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  buttonColor: kSuccessColor,
                ));
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content:
              Text("${e.toString()}\n Procure o suporte com a equipe LMTS"),
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

  void confirmDeliver(BuildContext context, int id) async {
    try {
      delivery = await repository.confirmDelivery(id);
      if (delivery == true) {
        showDialog(
            context: context,
            builder: (context) => DefaultAlertDialogOneButton(
                  title: 'Sucesso',
                  body: 'O pedido está pronto',
                  confirmText: 'Ok',
                  onConfirm: () {
                    navigator?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>const OrdersScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  buttonColor: kSuccessColor,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => DefaultAlertDialogOneButton(
                  title: 'Erro',
                  body: 'Erro na entrega',
                  confirmText: 'Ok',
                  onConfirm: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const OrdersScreen()),
                    );
                  },
                  buttonColor: kSuccessColor,
                ));
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Erro'),
          content:
              Text("${e.toString()}\n Procure o suporte com a equipe LMTS"),
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

  Future<void> fetchOrders() async {
    UserStorage userStorage = UserStorage();
    String userId = await userStorage.getUserId();
    try {
      var fetchedOrders = await repository.getOrders(userId);
      fetchedOrders.sort((a, b) => b.id!.compareTo(a.id!));
      orders.assignAll(fetchedOrders); // Atualiza a lista de pedidos
      await populateOrderCard(); // Atualiza os cartões de pedidos
      update(); // Notifica a tela sobre a atualização
    } catch (e) {
      print('Erro ao buscar pedidos: $e');
    }
  }

  Future<List<OrderCard>> populateOrderCard() async {
    List<OrderCard> list = [];
    UserStorage userStorage = UserStorage();
    var token = await userStorage.getUserToken();
    var userId = await userStorage.getUserId();
    bancaModel = await homeRepository.getBancaPrefs(token, userId);

    for (var order in orders) {
      if (order.status != "pedido recusado" &&
          order.status != "pagamento expirado" &&
          order.status != "pedido entregue") {
        OrderCard card = OrderCard(order, this);
        list.add(card);
      }
    }

    pedidos = list; // Atualiza a lista de pedidos exibidos
    return list;
  }

  Future<String> fetchUserDetails(int userId) async {
    try {
      var userDetails = await repository.fetchUserDetails(userId);
      if (userDetails != null && userDetails.containsKey('user')) {
        return userDetails['user']['name']; // Retorna apenas o nome do usuário
      } else {
        return "Nome não encontrado"; // Retorna uma mensagem padrão
      }
    } catch (e) {
      print('Erro ao buscar nome do usuário: $e');
      return "Erro ao buscar usuário"; // Retorna uma mensagem de erro
    }
  }

  Future<void> pickComprovante() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        _comprovante = File(result.files.single.path!);
        _comprovanteType = result.files.single.extension;
        _pdfPath = (_comprovanteType == 'pdf') ? _comprovante!.path : null;
        update();
      } else {
        debugPrint('Nenhum arquivo selecionado');
      }
    } catch (e) {
      debugPrint('Erro ao selecionar arquivo: $e');
    }
  }

  Future<void> loadPDF(String? path) async {
    try {
      if (path != null && path.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    } catch (e) {
      debugPrint('Erro ao carregar PDF: $e');
      throw Exception('Erro ao carregar PDF');
    }
  }

  Future<void> downloadComprovante(int orderId) async {
    try {
      _downloadPath = await repository.downloadComprovante(orderId);
      _comprovanteType = _downloadPath!.split('.').last;
      _pdfPath = (_comprovanteType == 'pdf') ? _downloadPath : null;
      update();
    } catch (e) {
      debugPrint('Erro ao baixar comprovante: $e');
    }
  }

  Future<void> fetchComprovanteBytes(int orderId) async {
    try {
      _comprovanteBytes = await repository.getComprovanteBytes(orderId);
      _comprovanteType = detectFileType(_comprovanteBytes!);
      update();
    } catch (e) {
      debugPrint('Erro ao obter bytes do comprovante: $e');
    }
  }

  String detectFileType(Uint8List bytes) {
    final pdfHeader = [0x25, 0x50, 0x44, 0x46];
    final jpgHeader = [0xFF, 0xD8, 0xFF];
    final pngHeader = [0x89, 0x50, 0x4E, 0x47];

    bool matchesHeader(Uint8List bytes, List<int> header) {
      for (int i = 0; i < header.length; i++) {
        if (bytes[i] != header[i]) {
          return false;
        }
      }
      return true;
    }

    if (bytes.length >= 4 && matchesHeader(bytes, pdfHeader)) {
      return 'pdf';
    } else if (bytes.length >= 3 && matchesHeader(bytes, jpgHeader)) {
      return 'jpg';
    } else if (bytes.length >= 4 && matchesHeader(bytes, pngHeader)) {
      return 'png';
    } else {
      return 'unknown';
    }
  }

  Future<List<PedidoModel>> loadList() async {
    UserStorage userStorage = UserStorage();
    var userId = await userStorage.getUserId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listaString = prefs.getStringList('$userId/vendas') ?? [];
    return listaString
        .map((string) => PedidoModel.fromJson(json.decode(string)))
        .toList();
  }

  List<ProdutoPedidoModel> getItensDoPedido(int pedidoId) {
    var pedido = orders.firstWhere((order) => order.id == pedidoId,
        orElse: () => PedidoModel(consumidorId: pedidoModel!.consumidorId));
    return pedido.listaDeProdutos ?? [];
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }
}
