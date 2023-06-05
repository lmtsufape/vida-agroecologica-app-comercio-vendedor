import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';

class AddProductsController extends GetxController {
  ScreenState screenState = ScreenState.idle;

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

  double changeProfit(String salePrice, String costPrice) {
    salePrice = salePrice
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
    costPrice = costPrice
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');

    print(salePrice);

    double profit = 0.0;
    if (salePrice.isNotEmpty && costPrice.isNotEmpty) {
      profit =
          double.parse(salePrice) - double.parse(costPrice);
    }

    return profit;
  }
}
