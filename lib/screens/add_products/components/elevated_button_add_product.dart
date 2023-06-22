import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/screens/add_products/add_products_repository.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../shared/components/dialogs/default_alert_dialog.dart';

class ElevatedButtonAddProduct extends StatefulWidget {
  final AddProductsController controller;
  const ElevatedButtonAddProduct(this.controller,
      {Key? key})
      : super(key: key);

  static ButtonStyle styleEditProduct =
      ElevatedButton.styleFrom(
    backgroundColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
  );

  @override
  State<ElevatedButtonAddProduct> createState() =>
      _ElevatedButtonAddProductState();
}

class _ElevatedButtonAddProductState
    extends State<ElevatedButtonAddProduct> {
  AddProductsRepository repository =
      AddProductsRepository();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: () {
          if (widget.controller.validateEmptyFields() ==
              false) {
            showDialog(
                context: context,
                builder: (context) => DefaultAlertDialog(
                      title: 'Erro',
                      body:
                          'Preencha todos os campos e adicione uma imagem',
                      cancelText: 'Ok',
                      confirmText: 'Ok',
                      onConfirm: () => Get.back(),
                      cancelColor: kErrorColor,
                      confirmColor: kSuccessColor,
                    ));
            print(widget.controller.costPrice);
            print(widget.controller.salePrice);
            print(widget.controller.stock);
            print(widget.controller.description);
            print(widget.controller.productId);
          } else {
            widget.controller.registerProduct(context);
          }
        },
        style: ElevatedButtonAddProduct.styleEditProduct,
        child: Text(
          'Adicionar',
          style: TextStyle(
              color: kTextColor,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
