// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/orders/orders_repository.dart';
import 'package:thunderapp/screens/orders/orders_screen.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import 'package:thunderapp/shared/core/models/user_model.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/style_constants.dart';
import '../../shared/core/user_storage.dart';
import '../home/home_screen.dart';

class OrdersController extends GetxController {
  RxString statusOrder = ''.obs;
  int quantPedidos = 0;
  BancaModel? bancaModel;
  PedidoModel? pedidoModel;
  HomeScreenRepository homeRepository =
      HomeScreenRepository();
  List<PedidoModel> orders = [];
  List<OrderCard> pedidos = [];
  late Future<List<dynamic>> orderData;
  OrdersRepository repository = OrdersRepository();
  bool confirmSucess = false;
  bool confirmedOrder = false;
  Rx<User> user = User().obs;
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
      confirmSucess =
          await repository.confirmOrder(id, confirmedOrder);
      if (confirmSucess && confirmedOrder == true) {
        showDialog(
            context: context,
            builder: (context) =>
                DefaultAlertDialogOneButton(
                  title: 'Sucesso',
                  body: 'O pedido foi aceito',
                  confirmText: 'Ok',
                  onConfirm: () {
                    navigator?.pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  buttonColor: kSuccessColor,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                DefaultAlertDialogOneButton(
                  title: 'Sucesso',
                  body: 'O pedido foi negado',
                  confirmText: 'Ok',
                  onConfirm: () {
                    navigator?.pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen()),
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

  Future<List<OrderCard>> populateOrderCard() async {
    List<OrderCard> list = [];
    UserStorage userStorage = UserStorage();
    var token = await userStorage.getUserToken();
    var userId = await userStorage.getUserId();
    bancaModel =
        await homeRepository.getBancaPrefs(token, userId);
    var pedidos = await repository.getOrders();

    quantPedidos = pedidos.length;

    for (int i = 0; i < pedidos.length; i++) {
      if (pedidos[i].status != "pedido recusado" &&
          pedidos[i].status != "pagamento expirado" &&
          pedidos[i].status != "pedido entregue") {
        OrderCard card =
            OrderCard(pedidos[i], OrdersController());
        list.add(card);
      }
    }

    if (list.isNotEmpty) {
      update();
      return list;
    } else {
      print(list);
      log('CARD VAZIO');
      return list;
    }
  }

  @override
  void onInit() async {
    pedidos = await populateOrderCard();
    super.onInit();
    update();
  }

  Future<String> fetchUserDetails(int userId) async {
  try {
    var userDetails = await repository.fetchUserDetails(userId);
    if (userDetails != null && userDetails.containsKey('user')) {
      return userDetails['user']['name'];  // Retorna apenas o nome do usuário
    } else {
      return "Nome não encontrado"; // Retorna uma mensagem padrão
    }
  } catch (e) {
    print('Erro ao buscar nome do usuário: $e');
    return "Erro ao buscar usuário"; // Retorna uma mensagem de erro
  }
}

}
