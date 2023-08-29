import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/products/products_repository.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/constants/app_text_constants.dart';
import '../add_products/add_products_repository.dart';
import '../list_products/components/card_products_list.dart';

class ListProductsController extends GetxController {
  List<CardProductsList> products = [];
  int quantProducts = 0;
  int quantStock = 0;
  AddProductsRepository repository =
      AddProductsRepository();
  final TextEditingController _searchController =
      TextEditingController();

  TextEditingController get searchController =>
      _searchController;

  bool getImage(id, token) {
    NetworkImage response = NetworkImage(
        '$kBaseURL/produtos/$id/imagem',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token}"
        });

    if (response.isBlank == false) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<CardProductsList>>
      populateCardsProductsList() async {
    List<CardProductsList> list = [];
    UserStorage userStorage = UserStorage();

    var token = await userStorage.getUserToken();
    var products = await repository.getProducts();

    quantProducts = products.length;

    for (int i = 0; i < products.length; i++) {
      print(products[i]);
      CardProductsList card =
          CardProductsList(token, products[i]);
      list.add(card);
      if (products.isNotEmpty) {
        quantStock = products[i].estoque!;
      }
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
    products = await populateCardsProductsList();
    super.onInit();
    update();
  }
}
