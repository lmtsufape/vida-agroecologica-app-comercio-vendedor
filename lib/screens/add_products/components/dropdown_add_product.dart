import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/table_products_model.dart';

// ignore: must_be_immutable
class DropDownAddProduct extends StatefulWidget {
  late AddProductsController controller;

  DropDownAddProduct(this.controller, {Key? key})
      : super(key: key);

  @override
  State<DropDownAddProduct> createState() =>
      _DropDownAddProductState();
}

class _DropDownAddProductState
    extends State<DropDownAddProduct> {
  final dropValue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            'Nome do produto',
            style: TextStyle(color: kTextButtonColor),
          ),
        ),
        Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.height * 0.06,
            child:
                DropdownButtonFormField<TableProductsModel>(
              isExpanded: true,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  borderSide:
                      BorderSide(color: kTextButtonColor),
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: kPrimaryColor,
                size: size.width * 0.05,
              ),
              hint: const Text('Selecione'),
              value: null,
              items: widget.controller.products.map((obj) {
                return DropdownMenuItem<TableProductsModel>(
                  value: obj,
                  child: Text(obj.nome.toString()),
                );
              }).toList(),
              onChanged: (selectedObj) {
                setState(() {
                  widget.controller
                      .setProductId(selectedObj!.id);
                  widget.controller
                      .setDescription(selectedObj.nome);
                });
              },
            )),
      ],
    );
  }
}
