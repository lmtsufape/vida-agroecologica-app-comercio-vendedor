import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thunderapp/shared/core/models/table_products_model.dart';

import '../../shared/constants/app_text_constants.dart';
import '../../shared/core/user_storage.dart';
import 'edit_products_controller.dart';

class EditProductsRepository extends GetxController {
  late String userToken;
  List<TableProductsModel> products = [];
  TableProductsModel product = TableProductsModel();

  Future<List<TableProductsModel>> getProducts() async {
    Dio dio = Dio();
    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    var response =
        await dio.get('$kBaseURL/produtos/tabelados',
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer $userToken"
              },
            ));

    List<dynamic> responseData = response.data['produtos'];

    for (int i = 0; i < responseData.length; i++) {
      product = TableProductsModel(
          id: responseData[i]["id"],
          nome: responseData[i]["nome"],
          categoria: responseData[i]["categoria"]);
      products.add(product);
    }

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return products;
    }
    return [];
  }

  Future<bool> registerProduct(
      String? description,
      String? measure,
      int? stock,
      String? salePrice,
      String? costPrice,
      int? productId,
      int? bancaId) async {
    Dio dio = Dio();

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    var body = {
      "descricao": description.toString(),
      "tipo_unidade": measure
          .toString() /**Alterar para "measure" quando tiver a validação*/,
      "estoque": stock,
      "preco": salePrice,
      "custo": costPrice,
      "produto_tabelado_id": productId,
      "banca_id": bancaId,
    };

    print(body);

    var response = await dio.post("$kBaseURL/produtos",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ),
        data: body);

    print(response.statusCode);

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getImage(int? prodId) async {
    Dio dio = Dio();

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    print("função de pegar imagem");
    print(prodId);

    try {
      var response = await dio.get(
        '$kBaseURL/produtos/$prodId/imagem',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        }),
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct(context, int? prodId) async {
    Dio dio = Dio();

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    var response = await dio.delete(
      '$kBaseURL/produtos/$prodId',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      ),
    );
    if (kDebugMode) {
      print(response.statusCode);
    }
    print(response.statusCode);
    return true;
  }

  void editProducts(
      EditProductsController controller) async {
    Dio dio = Dio();

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    var body = {
      "descricao": controller.description,
      "tipo_unidade": controller.measure
          .toString() /**Alterar para "measure" quando tiver a validação*/,
      "estoque": controller.stock,
      "preco": controller.salePrice,
      "custo": controller.costPrice,
      "disponivel": false
    };
    print(body);

    var response = await dio.patch(
        "$kBaseURL/produtos/${controller.productId}",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ),
        data: body);

    print(response.statusCode);
  }
}
