import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'components/dropdown_edit_product.dart';
import 'components/dropdown_qtd_edit_product.dart';
import 'components/elevated_button_edit_product.dart';
import 'components/image_edit.dart';
import 'components/sale_infos.dart';
import 'edit_products_controller.dart';
import 'edit_products_repository.dart';

import 'package:thunderapp/shared/core/models/table_products_model.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/constants/style_constants.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  State<EditProductsScreen> createState() =>
      _EditProductsScreenState();
}

class _EditProductsScreenState
    extends State<EditProductsScreen> {
  EditProductsRepository repository =
      EditProductsRepository();

  Future<List<TableProductsModel>>? products;

  @override
  void initState() {
    products = repository.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<EditProductsController>(
      init: EditProductsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar produto',
            style: kTitle2.copyWith(color: kPrimaryColor),
          ),
          iconTheme:
              const IconThemeData(color: kPrimaryColor),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: ListView(
            children: [
              Divider(
                height: size.height * 0.008,
                color: Colors.transparent,
              ),
              Column(
                children: [
                  ImageEdit(controller),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Container(
                      width: size.width * 0.315,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              'Editar imagem',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize:
                                    size.height * 0.014,
                                decoration: TextDecoration
                                    .underline,
                                decorationColor:
                                    kPrimaryColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: size.height * 0.016,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: size.height * 0.03,
                color: Colors.transparent,
              ),
              DropDownEditProduct(controller),
              Divider(
                height: size.height * 0.03,
                color: Colors.transparent,
              ),
              Align(
                  alignment:
                      AlignmentDirectional.centerStart,
                  child: Text(
                    'Informações de venda',
                    style: TextStyle(
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w500),
                  )),
              Divider(
                height: size.height * 0.02,
                color: Colors.transparent,
              ),
              SaleInfos(controller),
              Divider(
                height: size.height * 0.04,
                color: Colors.transparent,
              ),
              Align(
                  alignment:
                      AlignmentDirectional.centerStart,
                  child:
                      DropDownQtdEditProduct(controller)),
              Divider(
                height: size.height * 0.04,
                color: Colors.transparent,
              ),
              ElevatedButtonEditProduct(controller),
            ],
          ),
        ),
      ),
    );
  }
}
