import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/components/stock_add_product.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class DropDownQtdAddProduct extends StatelessWidget {
  final dropValue = ValueNotifier('');
  final dropOpcoes = [
    'unidade',
    'fracionario',
    'peso',
  ];

  DropDownQtdAddProduct({Key? key}) : super(key: key);

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
              height: size.height * 0.06,
              width: size.width * 0.57,
              child: ValueListenableBuilder(
                  valueListenable: dropValue,
                  builder: (BuildContext context,
                      String value, _) {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          borderSide: BorderSide(
                              color: kTextButtonColor),
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: kPrimaryColor,
                        size: size.width * 0.05,
                      ),
                      hint: Text('Unidade'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (escolha) => dropValue
                          .value = escolha.toString(),
                      items: dropOpcoes
                          .map(
                            (op) => DropdownMenuItem(
                              child: Text(op),
                              value: op,
                            ),
                          )
                          .toList(),
                    );
                  }),
            ),
          ],
        ),
        StockAddProduct(dropValue.value),
      ],
    );
  }
}
