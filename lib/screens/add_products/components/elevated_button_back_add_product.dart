import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../shared/components/dialogs/default_alert_dialog.dart';

class ElevatedButtonBackAddProduct extends StatefulWidget {
  final AddProductsController controller;
  const ElevatedButtonBackAddProduct(this.controller,
      {Key? key})
      : super(key: key);

  static ButtonStyle styleEditProduct =
  ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  State<ElevatedButtonBackAddProduct> createState() =>
      _ElevatedButtonBackAddProductState();
}

class _ElevatedButtonBackAddProductState
    extends State<ElevatedButtonBackAddProduct> {
  bool response = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: OutlinedButton(
        onPressed: () {
          setState(() async {
            var response =
            widget.controller.validateEmptyFields();
            // ignore: unrelated_type_equality_checks
            if (response == false) {
              showDialog(
                  context: context,
                  builder: (context) => DefaultAlertDialog(
                    title: 'Erro',
                    body: 'Preencha todos os campos',
                    cancelText: 'Ok',
                    confirmText: 'Ok',
                    onConfirm: () => Get.back(),
                    cancelColor: kErrorColor,
                    confirmColor: kSuccessColor,
                  ));
            } else {
              showDialog(
                  context: context,
                  builder: ((context) => DefaultAlertDialog(
                    title: 'Success',
                    body:
                    'Produto cadastrado com sucesso',
                    cancelText: 'Ok',
                    confirmText: 'Ok',
                    onConfirm: () =>
                        Navigator.pushNamed(
                            context, Screens.products),
                    cancelColor: kErrorColor,
                    confirmColor: kSuccessColor,
                  )));
            }
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.orange, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          'Voltar',
          style: TextStyle(
              color: Colors.orange,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
