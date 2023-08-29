import 'package:flutter/material.dart';
import 'package:thunderapp/screens/products/products_controller.dart';
import 'package:thunderapp/screens/products/components/stock_add_product.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class DropDownQtdAddProduct extends StatefulWidget {
  final ProductsController controller;

  const DropDownQtdAddProduct(this.controller, {Key? key})
      : super(key: key);

  @override
  State<DropDownQtdAddProduct> createState() =>
      _DropDownQtdAddProductState();
}

class _DropDownQtdAddProductState
    extends State<DropDownQtdAddProduct> {
  final dropValue = ValueNotifier('');

  final dropOpcoes = [
    'unidade',
    'fracionario',
    'peso',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                'Unidade de medida',
                style: TextStyle(color: kTextButtonColor),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              height: size.height * 0.05,
              width: size.width * 0.57,
              child: ValueListenableBuilder(
                  valueListenable: dropValue,
                  builder: (BuildContext context,
                      String value, _) {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.orange,
                        size: size.width * 0.05,
                      ),
                      hint: const Text('Unidade'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (escolha) {
                        setState(() {
                          dropValue.value =
                              escolha.toString();
                          widget.controller.setMeasure(
                              escolha.toString());
                        });
                      },
                      items: dropOpcoes
                          .map(
                            (op) => DropdownMenuItem(
                              value: op,
                              child: Text(op),
                            ),
                          )
                          .toList(),
                    );
                  }),
            ),
          ],
        ),
        StockAddProduct(widget.controller),
      ],
    );
  }
}
