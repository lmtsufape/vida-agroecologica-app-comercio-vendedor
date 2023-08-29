import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thunderapp/shared/core/models/cliente_pedido_model.dart';
import 'package:thunderapp/shared/core/models/consumidor_pedido_model.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import 'package:thunderapp/shared/core/models/produto_pedido_model.dart';
import '../../shared/constants/app_text_constants.dart';
import '../../shared/core/user_storage.dart';

class OrdersRepository extends GetxController {
  late String userToken;

  Future<List<PedidoModel>> getOrders() async {
    Dio dio = Dio();
    UserStorage userStorage = UserStorage();
    List<PedidoModel> orders = [];
    List<dynamic> all;
    List<dynamic> itensList;
    List<ProdutoPedidoModel> itens = [];

    userToken = await userStorage.getUserToken();

    var response = await dio.get('$kBaseURL/vendas',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ));

    print(response.data['transações']);

    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      all = response.data['transações'];
      if (all.isNotEmpty) {
        for (int i = 0; i < all.length; i++) {
          itensList = all[i]['itens'];
          for (int j = 0; j < itensList.length; j++) {
            ProdutoPedidoModel produtoList = ProdutoPedidoModel(
                itensList[j]['id'].toString(),
                itensList[j]['tipo_unidade'].toString(),
                itensList[j]['quantidade'],
                itensList[j]['preco']);
            itens.add(produtoList);
          }
          PedidoModel order = PedidoModel(
            all[i]['id'].toString(),
            all[i]['status'].toString(),
            all[i]['data_pedido'].toString(),
            all[i]['subtotal'],
            all[i]['taxa_entrega'],
            all[i]['total'],
            all[i]['consumidor_id'].toString(),
            all[i]['produtor_id'].toString(),
            all[i]['forma_pagamento_id'].toString(),
            all[i]['tipo_entrega'].toString(),
            itens,
          );
          orders.add(order);
        }
      }
      return orders;
    }
    return [];
  }
}
