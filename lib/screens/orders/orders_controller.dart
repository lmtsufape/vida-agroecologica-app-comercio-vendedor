import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thunderapp/screens/orders/orders_repository.dart';
import 'package:thunderapp/screens/orders/orders_screen.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';



class OrdersController extends GetxController {

  int quantPedidos = 0;
  List<PedidoModel> orders = [];
  List<OrderCard> pedidos = [];
  late Future<List<dynamic>> orderData;
  OrdersRepository repository = OrdersRepository();

  List<PedidoModel> get getOrders => orders;

  Future<List<OrderCard>> populateOrderCard() async {
    List<OrderCard> list = [];

    var pedidos = await repository.getOrders();

    quantPedidos = pedidos.length;

    for (int i = 0; i < pedidos.length; i++) {
      OrderCard card = OrderCard(pedidos[i]);
      list.add(card);
    }

    if (list.isNotEmpty) {
      update();
      return list;
    } else {
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

}

