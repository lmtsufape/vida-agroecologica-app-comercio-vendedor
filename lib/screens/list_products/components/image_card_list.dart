import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/screens/list_products/list_products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../../shared/constants/app_text_constants.dart';
import '../../../shared/core/models/products_model.dart';

// ignore: must_be_immutable
class ImageCardList extends StatefulWidget {
  ProductsModel model;
  ImageCardList(this.model ,{Key? key}) : super(key: key);

  @override
  State<ImageCardList> createState() => _ImageCardListState();
}

class _ImageCardListState extends State<ImageCardList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.4,
      child: AspectRatio(
        aspectRatio: 12/9,
        child: Material(
          elevation: 2,
          shadowColor: Colors.black,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (widget.model.id == null) {
                return const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: kPrimaryColor,
                );
              } else {
                return Image(
                    image: NetworkImage(
                      '$kBaseURL/imagens/produtos/${widget.model.id}',
                    ));
              }
            },
          ),
        ),
      ),
    );
  }
}