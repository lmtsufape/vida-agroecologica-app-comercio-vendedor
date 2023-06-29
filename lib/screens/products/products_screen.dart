import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:thunderapp/screens/products/components/add_button.dart';
import 'package:thunderapp/screens/products/components/card_products.dart';
import 'package:thunderapp/screens/products/components/product_search_bar.dart';
import 'package:thunderapp/screens/products/products_controller.dart';

import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/constants/style_constants.dart';
import '../screens_index.dart';
import 'components/info_cards_products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Produtos',
                  style: kTitle2.copyWith(
                      color: kPrimaryColor),
                ),
                iconTheme: const IconThemeData(
                    color: kPrimaryColor),
              ),
              body: Container(
                width: size.width,
                height: size.height,
                padding:
                    const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: <Widget>[
                     InfoCards(controller),
                    const VerticalSpacerBox(
                        size: SpacerSize.medium),
                    ProductSearchBar(
                        controller:
                            controller.searchController,
                        onSearch: () {}),
                    const VerticalSpacerBox(
                        size: SpacerSize.tiny),
                    AddButton(
                        onPressed: () =>
                            Navigator.pushNamed(context,
                                Screens.editProducts)),
                    const VerticalSpacerBox(
                        size: SpacerSize.large),
                    Column(
                      children: controller.products,
                    )
                  ],
                ),
              ),
            ));
  }
}
