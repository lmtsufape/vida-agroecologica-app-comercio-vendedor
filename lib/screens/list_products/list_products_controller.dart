import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/products/products_repository.dart';

import '../list_products/components/card_products_list.dart';

class ListProductsController extends GetxController {
  List<CardProductsList> products = [];
  int quantProducts = 0;
  int quantStock = 0;
  ProductsRepository repository = ProductsRepository();
  final TextEditingController _searchController =
  TextEditingController();

  TextEditingController get searchController =>
      _searchController;

  Future<List<CardProductsList>> populateCardsProductsList() async {
    List<CardProductsList> list = [];

    var products = await repository.getProducts();

    quantProducts = products.length;

    for (int i = 0; i < products.length; i++) {
      CardProductsList card = CardProductsList(products[i]);
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