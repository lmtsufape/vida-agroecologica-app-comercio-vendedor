import 'package:flutter/material.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/screens/products/products_screen.dart';
import 'package:thunderapp/screens/list_products/components/image_card_list.dart';
import 'package:thunderapp/shared/core/models/products_model.dart';

import '../../add_products/add_products_screen.dart';

class CardProductsList extends StatefulWidget {
  String userToken;
  ProductsModel model;
  CardProductsList(this.userToken, this.model, {Key? key})
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
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return ProductsScreen();
            })),
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
                              'R\$ ${widget.model.preco.toString()}',
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
