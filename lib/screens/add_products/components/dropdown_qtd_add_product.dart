import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/screens/add_products/components/stock_add_product.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class DropDownQtdAddProduct extends StatefulWidget {
  final AddProductsController controller;

  const DropDownQtdAddProduct(this.controller, {Key? key})
      : super(key: key);

  @override
  State<DropDownQtdAddProduct> createState() =>
      _DropDownQtdAddProductState();
}

class _DropDownQtdAddProductState
    extends State<DropDownQtdAddProduct> {
  final dropValue = ValueNotifier('');

  final List<String> dropOpcoes = [
    'Unidade',
    'Bandeja',
    'Kg',
    'Litro',
    'Mão',
    'Molho',
    'Dúzia',
    'Peso',
    'Arroba',
    'Pote',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dropOpcoes.sort((a, b) => a.compareTo(b));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'Unidade de medida',
                style: TextStyle(
                  fontSize: size.height * 0.018,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              width: size.width * 0.4,
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
                      hint: Text(
                        'Selecione',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          color: kTextButtonColor,
                        ),
                      ),
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
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(fontSize: 12),
                      ),
                      validator: (dropValue) {
                        if (dropValue == null) {
                          return 'Obrigatório';
                        }
                        return null;
                      },
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
