import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/add_products/add_products_repository.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
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
  int? productId;
  late String userToken;
  late String userId;
  late bool hasImage = false;

  HomeScreenRepository homeRepository =
      HomeScreenRepository();

  ListProductsRepository repository =
      ListProductsRepository();
  final TextEditingController _searchController =
      TextEditingController();

  TextEditingController get searchController =>
      _searchController;

  void setHasImage(bool value){
    hasImage = value;
    update();
  }

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

    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        print(products[i]);
        CardProductsList card = CardProductsList(token, products[i], repository);
        list.add(card);
        if (products.isNotEmpty) {
          quantStock += products[i].estoque!;
        }
      }
    } else {
      log('CARD VAZIO');
      list = [];
      return list;
    }

    // Verifica se a lista está vazia antes de tentar acessá-la
    if (list.isNotEmpty) {
      update();
      return list;
    } else {
      throw RangeError('Lista vazia');
    }
  }


  Future<bool> getImage(int? prodId) async{
    Dio dio = Dio();

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    print("list: ${prodId}");

    try{
      var response = await dio.get(
        '$kBaseURL/produtos/$prodId/imagem',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        }),
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        print("aqui é true");
        return true;
      }
      else if(response.statusCode == 404){
        print('aqui é false 1');
        print("ERRO 404 NÃO TEM FOTO");
        return false;
      }
      else{
        print('aqui é false 2');
        return false;
      }
    }catch(e){
      print('aqui é false 3');
      print(e);
      return false;
    }
  }

  @override
  void onInit() async {
    products = await populateCardsProductsList();
    super.onInit();
    update();
  }
}
