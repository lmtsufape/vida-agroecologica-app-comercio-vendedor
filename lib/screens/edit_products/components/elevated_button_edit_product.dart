import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/edit_products/edit_products_repository.dart';
import 'package:thunderapp/screens/home/home_screen.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
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
    // ignore: unused_local_variable
    EditProductsRepository repository =
        EditProductsRepository(); // ERRADO
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: () async {
          final isValidForm = widget
              .controller.formKey.currentState!
              .validate();
          if (isValidForm) {
            var response = await widget.controller
                .validateEmptyFields();
            if (response) {
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: ((context) =>
                    DefaultAlertDialogOneButton(
                      title: 'Sucesso',
                      body: 'Produto editado com sucesso',
                      confirmText: 'Ok',
                      onConfirm: () =>
                          Get.offAll(() => const HomeScreen()),
                      buttonColor: kSuccessColor,
                    )),
              );
            }
          }
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
