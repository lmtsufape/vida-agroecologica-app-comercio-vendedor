import 'package:flutter/material.dart';

import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';

class CardProducts extends StatefulWidget {
  ProductsModel model;
  CardProducts(this.model, {Key? key}) : super(key: key);

  @override
  State<CardProducts> createState() => _CardProductsState();
}

class _CardProductsState extends State<CardProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.066,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 14),
              child: Text(
                widget.model.nome.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.height * 0.024),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(end: 14),
              child: Column(
                children: [
                  Text(
                    'Quantidade',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.016,
                        color: Colors.grey),
                  ),
                  Text(widget.model.estoque.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.height * 0.024,
                          color: kPrimaryColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
