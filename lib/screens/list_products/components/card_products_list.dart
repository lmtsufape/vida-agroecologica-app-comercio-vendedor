import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/screens/add_products/add_products_screen.dart';
import 'package:thunderapp/screens/list_products/components/image_card_list.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';
import '../../../shared/constants/style_constants.dart';
import '../list_products_repository.dart';

class CardProductsList extends StatefulWidget {
  String userToken;
  ProductsModel model;
  ListProductsRepository repository;
  CardProductsList(this.userToken, this.model, this.repository, {Key? key})
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
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.1,
          child: InkWell(
            onTap: () {
              showDialog(context: context, builder: (context) =>
                AlertDialog(
                  title: Center(
                    child: const Text(
                      'Excluir produto?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  content: const Text(
                    'Você tem certeza que deseja excluir este produto?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  actions: [
                    Center(
                      child: Wrap(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            // ignore: sort_child_properties_last
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: ElevatedButton(
                              onPressed: () => widget.repository
                                  .deleteProduct(widget.model.id),
                              // ignore: sort_child_properties_last
                              child: const Text(
                                'Excluir',
                                style: TextStyle(
                                  color: kBackgroundColor,
                                  fontSize: 20,
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
                        widget.userToken, widget.model),
                    Container(
                      width: size.width * 0.55,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsetsDirectional
                            .only(start: 14),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: size.height * 0.008,
                              color: Colors.transparent,
                            ),
                            Text(
                              widget.model.descricao
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                  fontSize:
                                      size.height * 0.018),
                            ),
                            Divider(
                              height: size.height * 0.006,
                              color: Colors.transparent,
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
                              height: size.height * 0.004,
                              color: Colors.transparent,
                            ),
                            Text(
                                NumberFormat.simpleCurrency(locale:'pt-BR', decimalDigits: 2).format(widget.model.preco),
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
