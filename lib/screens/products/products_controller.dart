import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/products/components/card_products.dart';
import 'package:thunderapp/screens/products/components/info_cards_products.dart';
import 'package:thunderapp/screens/products/products_repository.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';

class ProductsController extends GetxController {
  List<CardProducts> products = [];
  int quantProducts = 0;
  int quantStock = 0;
  ProductsRepository repository = ProductsRepository();
  final TextEditingController _searchController =
      TextEditingController();

  TextEditingController get searchController =>
      _searchController;

  Future<List<CardProducts>> populateCardsProducts() async {
    List<CardProducts> list = [];

    var products = await repository.getProducts();

    quantProducts = products.length;

    for (int i = 0; i < products.length; i++) {
      CardProducts card = CardProducts(products[i]);
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
    products = await populateCardsProducts();
    super.onInit();
    update();
  }
}
