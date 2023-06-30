import 'package:flutter/material.dart';
import 'package:thunderapp/screens/products/products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class InfoCards extends StatefulWidget {
  ProductsController controller;
  InfoCards(this.controller, {Key? key}) : super(key: key);

  @override
  State<InfoCards> createState() => _InfoCardsState();
}

class _InfoCardsState extends State<InfoCards> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.08,
          width: size.width * 0.40,
          child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero),
            elevation: 3,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Divider(
                    height: size.height * 0.005,
                    color: Colors.transparent,
                  ),
                  Text(
                    'Produtos',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: size.height * 0.020,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.controller.quantProducts
                        .toString(),
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            height: size.height * 0.08,
            width: size.width * 0.40,
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero),
              elevation: 3,
              child: Column(
                children: [
                  Divider(
                    height: size.height * 0.005,
                    color: Colors.transparent,
                  ),
                  Text(
                    'Quantidade total',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: size.height * 0.020,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.controller.quantStock.toString(),
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
