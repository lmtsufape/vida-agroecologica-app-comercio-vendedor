import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thunderapp/screens/add_products/add_products_repository.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';

import 'package:thunderapp/shared/core/models/table_products_model.dart';

class AddProductsController extends GetxController {
  ScreenState screenState = ScreenState.idle;

  // Informações para o post de cadastro de produtos.

  String? description;
  String measure = 'unidade';
  int? productId;
  int? stock;
  double? costPrice;
  double? salePrice;

  // -----------------------

  AddProductsRepository repository =
      AddProductsRepository();
  List<TableProductsModel> products = [];
  final TextEditingController _stockController =
      TextEditingController();

  CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter(
          locale: 'pt-Br', symbol: 'R\$');

  final TextEditingController _saleController =
      TextEditingController();

  final TextEditingController _costController =
      TextEditingController();

  TextEditingController get saleController =>
      _saleController;

  TextEditingController get costController =>
      _costController;

  TextEditingController get stockController =>
      _stockController;

  double changeProfit(String salePrice, String costPrice) {
    salePrice = salePrice
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
    costPrice = costPrice
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');

    double profit = 0.0;
    if (salePrice.isNotEmpty && costPrice.isNotEmpty) {
      profit =
          double.parse(salePrice) - double.parse(costPrice);
    }

    return profit;
  }

  void setProductId(int? value) {
    productId = value;
    update();
  }

  void setDescription(String? value) {
    description = value;
    update();
  }

  void setMeasure(String value) {
    measure = value;
    update();
  }

  void setStock() {
    String value = stockController.text
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
    if (value.isNotEmpty) {
      stock = int.parse(value);
    }
    update();
  }

  void setCostPrice() {
    String value = costController.text
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
    if (value.isNotEmpty) {
      costPrice = double.parse(value);
    }
    update();
  }

  void setSalePrice() {
    String value = saleController.text
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
    if (value.isNotEmpty) {
      salePrice = double.parse(value);
    }
    update();
  }

  void loadTableProducts() async {
    products = await repository.getProducts();
    update();
  }

  bool validateEmptyFields() {
    if (description == null ||
        measure == null ||
        _stockController.text.isEmpty ||
        _saleController.text.isEmpty ||
        _costController.text.isEmpty ||
        productId == null) {
      print(
          'Error, o user não preencheu todos os campos, retornando falso');
      return false;
    } else {
      print('foi true');
      return true;
    }
  }

  void registerProduct(BuildContext context) async {
    repository.registerProduct(description, measure, stock,
        salePrice, costPrice, productId);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadTableProducts();
    update();
  }
}
