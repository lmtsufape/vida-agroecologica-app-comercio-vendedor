import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/screens/edit_products/edit_products_repository.dart';
import 'package:thunderapp/screens/home/home_screen.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';
import 'package:thunderapp/shared/core/models/table_products_model.dart';

import '../../../shared/components/dialogs/default_alert_dialog.dart';
import '../edit_products_controller.dart';

class ElevatedButtonEditProduct extends StatefulWidget {
  final EditProductsController controller;

  const ElevatedButtonEditProduct(this.controller,
      {Key? key})
      : super(key: key);

  static ButtonStyle styleEditProduct =
      ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
  );

  @override
  State<ElevatedButtonEditProduct> createState() =>
      _ElevatedButtonEditProductState();
}

class _ElevatedButtonEditProductState
    extends State<ElevatedButtonEditProduct> {
  @override
  Widget build(BuildContext context) {
    EditProductsRepository repository =
        EditProductsRepository(); // ERRADO
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: () async {
          repository.editProducts(widget.controller);
        },
        style: ElevatedButtonEditProduct.styleEditProduct,
        child: Text(
          'Salvar',
          style: TextStyle(
              color: kTextColor,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
