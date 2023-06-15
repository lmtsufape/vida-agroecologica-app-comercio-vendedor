import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/components/dropdown_add_product.dart';
import 'package:thunderapp/screens/add_products/components/dropdown_qtd_add_product.dart';
import 'package:thunderapp/screens/add_products/components/elevated_button_add_product.dart';
import 'package:thunderapp/screens/add_products/components/image_edit.dart';
import 'package:thunderapp/screens/add_products/components/sale_infos.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/constants/style_constants.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar produto',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
        iconTheme:
            const IconThemeData(color: kPrimaryColor),
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
            DropDownAddProduct(),
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
              height: size.height * 0.02,
              color: Colors.transparent,
            ),
            SaleInfos(),
            Divider(
              height: size.height * 0.02,
              color: Colors.transparent,
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: DropDownQtdAddProduct()),
            Divider(
              height: size.height * 0.03,
              color: Colors.transparent,
            ),
            const ElevatedButtonAddProduct(),
          ],
        ),
      ),
    );
  }
}
