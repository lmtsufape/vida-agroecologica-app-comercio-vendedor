import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/assets/index.dart';
import 'package:thunderapp/screens/edit_products/components/dropdown_edit_product.dart';
import 'package:thunderapp/screens/edit_products/components/dropdown_qtd_edit_product.dart';
import 'package:thunderapp/screens/edit_products/components/elevated_button_edit_product.dart';
import 'package:thunderapp/screens/edit_products/components/image_edit.dart';
import 'package:thunderapp/screens/edit_products/components/sale_infos.dart';
import 'package:thunderapp/screens/edit_products/components/stock_edit_product.dart';
import 'package:thunderapp/screens/products/components/add_button.dart';
import 'package:thunderapp/screens/products/components/card_products.dart';
import 'package:thunderapp/screens/products/components/search_bar.dart';
import 'package:thunderapp/screens/products/products_controller.dart';
import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/constants/style_constants.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar produto',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
      ),
      /*drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Sair'),
                trailing: const Icon(
                  Icons.exit_to_app,
                  size: 20,
                  color: kPrimaryColor,
                ),
                onTap: () {},
              )
            ],
          )),*/
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Divider(
              height: size.height * 0.04,
              color: Colors.transparent,
            ),
            ImageEdit(),
            Divider(
              height: size.height * 0.025,
              color: Colors.transparent,
            ),
            DropDownEditProduct(),
            Divider(
              height: size.height * 0.025,
              color: Colors.transparent,
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Informações de venda',
                  style: TextStyle(
                      fontSize: size.height * 0.024,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500),
                )),
            Divider(
              height: size.height * 0.01,
              color: Colors.transparent,
            ),
            SaleInfos(),
            Divider(
              height: size.height * 0.01,
              color: Colors.transparent,
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: DropDownQtdEditProduct()),
            Divider(
              height: size.height * 0.01,
              color: Colors.transparent,
            ),
            const Align(
                alignment: AlignmentDirectional.centerStart,
                child: StockEditProduct()),
            Divider(
              height: size.height * 0.020,
              color: Colors.transparent,
            ),
            const ElevatedButtonEditProduct(),
          ],
        ),
      ),
    );
  }
}
