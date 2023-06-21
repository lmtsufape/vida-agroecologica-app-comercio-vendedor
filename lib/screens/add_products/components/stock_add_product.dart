import 'package:flutter/material.dart';

import 'package:thunderapp/screens/add_products/add_products_controller.dart';

import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../components/forms/custom_text_form_field.dart';

class StockAddProduct extends StatelessWidget {
  final String? value;

  const StockAddProduct(this.value, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddProductsController controller =
        AddProductsController();
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estoque atual',
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: size.height * 0.017),
        ),
        Divider(
          height: size.height * 0.005,
          color: Colors.transparent,
        ),
        SizedBox(
          height: size.height * 0.06,
          width: size.width * 0.25,
          child: Card(
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: const BorderSide(
                    color: kTextButtonColor)),
            child: Align(
                alignment: Alignment.center,
                child: CustomTextFormField(
                  controller: controller.stockController,
                )),
          ),
        ),
      ],
    );
  }
}
