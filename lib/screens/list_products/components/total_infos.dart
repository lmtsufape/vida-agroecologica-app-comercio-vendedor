import 'package:flutter/material.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

// ignore: must_be_immutable
class TotalInfos extends StatelessWidget {
  ListProductsController controller;

  TotalInfos(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.13,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(121, 120, 120, 120), 
                blurRadius: 7.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOTAL DE PRODUTOS',
                style: TextStyle(
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor,
                ),
              ),
              Divider(
                height: size.height * 0.01,
                color: Colors.transparent,
              ),
              Text(
                controller.quantProducts.toString(),
                style: TextStyle(
                    fontSize: size.height * 0.020,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }
}
