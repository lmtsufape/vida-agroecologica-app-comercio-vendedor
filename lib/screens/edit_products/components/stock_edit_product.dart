import 'package:flutter/material.dart';

import 'package:thunderapp/screens/add_products/add_products_controller.dart';

import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../edit_products_controller.dart';

class StockEditProduct extends StatefulWidget {
  final EditProductsController controller;

  const StockEditProduct(this.controller, {Key? key})
      : super(key: key);

  @override
  State<StockEditProduct> createState() =>
      _StockEditProductState();
}

class _StockEditProductState
    extends State<StockEditProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estoque atual',
          style: TextStyle(
            fontSize: size.height * 0.017,
            color: kTextButtonColor,
          ),
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
            elevation: 0,
            child: ClipPath(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1)),
                ),
                alignment: Alignment.center,
                child: CustomTextFormField(
                    controller:
                        widget.controller.stockController,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.setStock();
                      });
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
