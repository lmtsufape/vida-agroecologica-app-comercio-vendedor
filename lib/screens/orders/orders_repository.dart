// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:thunderapp/shared/core/models/pedido_model.dart';
import '../../shared/constants/app_text_constants.dart';
import '../../shared/core/user_storage.dart';

class OrdersRepository extends GetxController {
  late String userToken;
  late String userId;
  final Dio _dio = Dio();

  // Future<List<PedidoModel>> getOrders(String id) async {
  //   PedidoModel pedido = PedidoModel();
  //   UserStorage userStorage = UserStorage();
  //   List<PedidoModel> orders = [];
  //   userToken = await userStorage.getUserToken();
  //   try {
  //     Response response = await _dio.get('$kBaseURL/transacoes/$id/vendas',
  //         options: Options(
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Accept": "application/json",
  //             "Authorization": "Bearer $userToken"
  //           },
  //         ));
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       List<dynamic> listDynamic = response.data['vendas'];
  //       print(listDynamic);
  //       for (int i = 0; i < listDynamic.length; i++) {
  //         if (listDynamic[i]["status"] == "aguardando confirmação") {
  //           pedido = PedidoModel(
  //             id: listDynamic[i]["id"],
  //             status: listDynamic[i]["status"].toString(),
  //             tipoEntrega: listDynamic[i]["tipo_entrega"].toString(),
  //             subtotal: listDynamic[i]["subtotal"],
  //             taxaEntrega: listDynamic[i]["taxa_entrega"],
  //             total: listDynamic[i]["total"],
  //             dataPedido: listDynamic[i]["data_pedido"],
  //             dataConfirmacao: listDynamic[i]["data_confirmacao"],
  //             dataCancelamento: listDynamic[i]["data_cancelamento"],
  //             dataPagamento: listDynamic[i]["data_pagamento"],
  //             dataEnvio: listDynamic[i]["data_envio"],
  //             dataEntrega: listDynamic[i]["data_entrega"],
  //             formaPagamentoId: listDynamic[i]["forma_pagamento_id"],
  //             consumidorId: listDynamic[i]["consumidor_id"],
  //             bancaId: listDynamic[i]["banca_id"],
  //           );
  //           orders.add(pedido);
  //           print(orders[i]);
  //         }
  //       }
  //       return orders;
  //     }
  //   } catch (e) {
  //     if (e is DioError) {
  //       final dioError = e;
  //       if (dioError.response != null) {
  //         final errorMessage = dioError.response!.data['errors'];
  //         print('Erro: $errorMessage');
  //         print("Erro ${e.toString()}");
  //       }
  //     }
  //   }
  //   return [];
  // }

  Future<List<PedidoModel>> getOrders() async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();
    userId = await userStorage.getUserId();

    log('Sending request with token: $userToken'); // Log do token

    try {
      var response = await _dio.get('$kBaseURL/transacoes/$userId/vendas',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              'Cache-Control': 'no-cache',
              "Authorization": "Bearer $userToken"
            },
          ));

      if (response.statusCode == 200) {
        /*  log('Response data: ${response.data}'); */

        if (response.data['vendas'] != null) {
          final jsonData = Map<String, dynamic>.from(response.data);
          final ordersJson = List.from(jsonData['vendas'])
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

          List<PedidoModel> orders = [];
          for (var orderJson in ordersJson) {
            var order = PedidoModel.fromJson(orderJson);
            orders.add(order);
          }

          // Ordenar os pedidos pela data
          orders.sort((a, b) => a.dataPedido!.compareTo(b.dataPedido!));

          return orders;
        } else {
          log('No vendas data available.');
          return [];
        }
      } else {
        throw Exception(
            'Falha em carregar os pedidos. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error making the request: $error');
      rethrow;
    }
  }

  Future<bool> confirmOrder(int pedidoId, bool confirm) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      var body = {
        "confirmacao": confirm,
      };

      print(body);

      Response response = await _dio.post(
        '$kBaseURL/transacoes/$pedidoId/confirmar',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ),
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage = dioError.response!.data['errors'];
          print('Erro: $errorMessage');
          print("Erro ${e.toString()}");
          return false;
        }
      }
      return false;
    }
  }

  Future<bool> confirmDelivery(int pedidoId) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      Response response = await _dio.post(
        '$kBaseURL/transacoes/$pedidoId/enviar',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage = dioError.response!.data['errors'];
          print('Erro: $errorMessage');
          print("Erro ${e.toString()}");
          return false;
        }
      }
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(int userId) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      Response response = await _dio.get(
        '$kBaseURL/users/$userId', // Modifique o URL conforme a estrutura da sua API
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ),
      );

      if (response.statusCode == 200) {
        // Decodificar a resposta JSON e retornar o objeto de usuário
        return jsonDecode(response.data);
      } else {
        print('Erro ao buscar detalhes do usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao fazer a chamada de API: $e');
      return null;
    }
  }
}
