import 'package:flutter/material.dart';

import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';

import '../../screens_index.dart';

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
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.07,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0.7,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 100),
                  child: Container(
                    width: size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      widget.model.nome.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.height * 0.020),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 14),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //return AddProductsScreen();
                      //}),);
                      Navigator.pushNamed(context, Screens.listProducts);
                    },
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      size: size.height * 0.045,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: size.height * 0.01, color: Colors.transparent,)
      ],
    );
  }
}
