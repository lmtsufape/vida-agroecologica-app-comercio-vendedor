import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/screens/edit_products/edit_products_screen.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/screens/add_products/add_products_screen.dart';
import 'package:thunderapp/screens/list_products/components/image_card_list.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';
import '../../../shared/components/dialogs/default_alert_dialog.dart';
import '../../../shared/constants/style_constants.dart';
import '../../../shared/core/models/table_products_model.dart';
import '../../home/home_screen.dart';
import '../../screens_index.dart';
import '../list_products_repository.dart';

class CardProductsList extends StatefulWidget {
  String userToken;
  ProductsModel model;
  ListProductsRepository repository;
  List<TableProductsModel> listTable;

  CardProductsList(this.userToken, this.model,
      this.repository, this.listTable,
      {Key? key})
      : super(key: key);

  @override
  State<CardProductsList> createState() =>
      _CardProductsListState();
}

class _CardProductsListState
    extends State<CardProductsList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.listTable.length);
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.115,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditProductsScreen(
                          widget.model)));
            },
            child: Ink(
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    ImageCardList(
                        widget.userToken,
                        widget.model.produtoTabeladoId,
                        widget.listTable),
                    Container(
                      width: size.width * 0.5615,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsetsDirectional
                            .only(start: 8, end: 0),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  widget.model.descricao
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight:
                                          FontWeight.w600,
                                      fontSize:
                                          size.height *
                                              0.018),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: size.width * 0.07,
                                  ),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder:
                                            (context) =>
                                                AlertDialog(
                                                  title:
                                                      Center(
                                                    child:
                                                        Text(
                                                      'Excluir produto?',
                                                      style:
                                                          TextStyle(
                                                        color:
                                                            Colors.black,
                                                        fontSize:
                                                            size.height * 0.020,
                                                      ),
                                                    ),
                                                  ),
                                                  content:
                                                      Text(
                                                    'Você tem certeza que deseja excluir este produto?',
                                                    style:
                                                        TextStyle(
                                                      color:
                                                          Colors.black,
                                                      fontSize:
                                                          size.height * 0.015,
                                                    ),
                                                  ),
                                                  actions: [
                                                    Center(
                                                      child:
                                                          Wrap(
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            // ignore: sort_child_properties_last
                                                            child: Text(
                                                              'Cancelar',
                                                              style: TextStyle(
                                                                color: kBackgroundColor,
                                                                fontSize: size.height * 0.020,
                                                              ),
                                                            ),
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: kSuccessColor,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 16),
                                                            child: ElevatedButton(
                                                              onPressed: () => widget.repository.deleteProduct(widget.model.id) == true
                                                                  ? showDialog(
                                                                      context: context,
                                                                      builder: (context) => DefaultAlertDialogOneButton(
                                                                            title: 'Erro',
                                                                            body: 'Impossível excluir esse produto',
                                                                            confirmText: 'Ok',
                                                                            onConfirm: () => Get.back(),
                                                                            buttonColor: kSuccessColor,
                                                                          ))
                                                                  : showDialog(
                                                                      context: context,
                                                                      builder: ((context) => DefaultAlertDialogOneButton(
                                                                            title: 'Sucesso',
                                                                            body: 'Produto excluído com sucesso',
                                                                            confirmText: 'Ok',
                                                                            onConfirm: () => Get.offAll(() => const HomeScreen()),
                                                                            buttonColor: kSuccessColor,
                                                                          ))),
                                                              child: Text(
                                                                'Excluir',
                                                                style: TextStyle(
                                                                  color: kBackgroundColor,
                                                                  fontSize: size.height * 0.020,
                                                                ),
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.redAccent,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                  },
                                ),
                              ],
                            ),
                            Text(
                              'Estoque atual: ${widget.model.estoque.toString()}',
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w500,
                                  fontSize:
                                      size.height * 0.016),
                            ),
                            Divider(
                              height: size.height * 0.002,
                              color: Colors.transparent,
                            ),
                            Text(
                              NumberFormat.simpleCurrency(
                                      locale: 'pt-BR',
                                      decimalDigits: 2)
                                  .format(
                                      widget.model.preco),
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w500,
                                  fontSize:
                                      size.height * 0.016),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: size.height * 0.01,
          color: Colors.transparent,
        )
      ],
    );
  }
}
