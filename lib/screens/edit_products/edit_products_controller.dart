// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';

import 'package:thunderapp/shared/core/models/table_products_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import 'edit_products_repository.dart';

class EditProductsController extends GetxController {
  ScreenState screenState = ScreenState.idle;

  // Informações para o post de cadastro de produtos.

  String? description;
  String? title;
  String measure = 'unidade';
  int? productId;
  int? stock;
  String? costPrice;
  String? salePrice;
  String? token;
  BancaModel? bancaModel;
  String? userId;
  late String userToken;
  bool hasImage = false;
  List<TableProductsModel> tableProducts = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // -----------------------
  EditProductsController(ProductsModel model) {
    description = model.descricao;
    title = model.titulo;
    productId = model.id;
    stock = model.estoque;
    costPrice = "1.00";
    salePrice = model.preco.toString();
  }

  HomeScreenRepository homeRepository = HomeScreenRepository();
  UserStorage userStorage = UserStorage();

  EditProductsRepository repository = EditProductsRepository();
  List<TableProductsModel> products = [];
  final TextEditingController _stockController = TextEditingController();

  // Inicialize o controller
  final TextEditingController _saleController = TextEditingController();

// Crie o formatador para o campo de preço
  final currencyFormatter = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2, // Garante sempre 2 casas decimais
  );

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  TextEditingController get saleController => _saleController;

  TextEditingController get titleController => _titleController;

  TextEditingController get descriptionController => _descriptionController;

  TextEditingController get stockController => _stockController;



  double changeProfit(String salePrice, String costPrice) {
    salePrice =
        salePrice.replaceAll(RegExp(r'[^0-9,.]'), '').replaceAll(',', '.');
    costPrice =
        costPrice.replaceAll(RegExp(r'[^0-9,.]'), '').replaceAll(',', '.');

    double profit = 0.0;
    if (salePrice.isNotEmpty && costPrice.isNotEmpty) {
      profit = double.parse(salePrice) - double.parse(costPrice);
    }

    return profit;
  }

  void setHasImage(bool value) {
    hasImage = value;
    update();
  }

  void setProductId(int? value) {
    productId = value;
    update();
  }

  void setDescription() {
    description = descriptionController.text;
    update();
  }

  void setTitle() {
    title = titleController.text;
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

  void setSalePrice() {
    // Remover os caracteres não numéricos e substituir a vírgula por ponto
    String value = saleController.text
        .replaceAll(RegExp(r'[^0-9,]'), '')
        .replaceAll(',', '.');

    // Verifica se o valor não está vazio ou nulo
    if (value.isNotEmpty) {
      // Converter para double
      double parsedValue = double.tryParse(value) ?? 0.0;

      // Formatar para 2 casas decimais
      String formattedValue = parsedValue.toStringAsFixed(2);

      // Atribuir ao controlador a String formatada
      salePrice = formattedValue;

      update();
    }
  }

  Future<bool> validateEmptyFields() async {
    try {
      if (measure.isEmpty ||
          _stockController.text.isEmpty ||
          _saleController.text.isEmpty ||
          _titleController.text.isEmpty ||
          productId == null) {
        log(measure);
        log(_stockController.text);
        log(_saleController.text);
        log(_titleController.text);
        log(productId.toString());
        log('Error, o user não preencheu todos os campos, retornando falso');
        return false;
      } else {
        var response = await repository.editProducts(this);
        if (response == true) {
          log('tá certo');
          return true;
        }
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

  Future<List<TableProductsModel>> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listaString =
        prefs.getStringList('listaProdutosTabelados') ?? [];
    return listaString
        .map((string) => TableProductsModel.fromJson(json.decode(string)))
        .toList();
  }

  TableProductsModel? search(int? tableProId) {
    for (int i = 0; i < tableProducts.length; i++) {
      if (tableProducts[i].id == tableProId) {
        return tableProducts[i];
      }
    }
    return null;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    tableProducts = await loadList();
    update();
  }
}
