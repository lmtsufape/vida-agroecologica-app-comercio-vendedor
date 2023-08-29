import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/products/products_controller.dart';

import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/constants/style_constants.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Adicionar produto',
                style:
                    kTitle2.copyWith(color: kPrimaryColor),
              ),
              iconTheme:
                  const IconThemeData(color: kPrimaryColor),
            ),
            body: ListView(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  padding:
                      const EdgeInsets.all(kDefaultPadding),
                  child: ListView(
                    children: [],
                  ),
                ),
              ],
            )));
  }
}
