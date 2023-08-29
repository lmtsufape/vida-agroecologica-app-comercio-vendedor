import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/products/products_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/constants/app_text_constants.dart';
import '../add_products/add_products_repository.dart';
import '../list_products/components/card_products_list.dart';
import 'list_products_repository.dart';

class ListProductsController extends GetxController {
  List<CardProductsList> products = [];
  BancaModel? bancaModel;
  int quantProducts = 0;
  int quantStock = 0;
  HomeScreenRepository homeRepository =
      HomeScreenRepository();

  ListProductsRepository repository =
      ListProductsRepository();
  final TextEditingController _searchController =
      TextEditingController();

  TextEditingController get searchController =>
      _searchController;

  Future<List<CardProductsList>>
      populateCardsProductsList() async {
    List<CardProductsList> list = [];
    UserStorage userStorage = UserStorage();
    var token = await userStorage.getUserToken();
    var userId = await userStorage.getUserId();
    bancaModel =
        await homeRepository.getBancaPrefs(token, userId);

    var products =
        await repository.getProducts(bancaModel?.id);

    quantProducts = products.length;

    for (int i = 0; i < products.length; i++) {
      print(products[i]);
      CardProductsList card =
          CardProductsList(token, products[i]);
      list.add(card);
      if (products.isNotEmpty) {
        quantStock += products[i].estoque!;
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
