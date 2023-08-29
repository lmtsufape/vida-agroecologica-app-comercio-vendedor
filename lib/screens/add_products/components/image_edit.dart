import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../../shared/constants/app_text_constants.dart';

// ignore: must_be_immutable
class ImageEdit extends StatefulWidget {
  AddProductsController? controller;
  ImageEdit(this.controller, {Key? key}) : super(key: key);

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.4,
      child: AspectRatio(
        aspectRatio: 1,
        child: Material(
          elevation: 3,
          shadowColor: Colors.black,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (widget.controller!.productId == null) {
                return const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: kPrimaryColor,
                );
              } else {
                return Image(
                    image: NetworkImage(
                  '$kBaseURL/imagens/produtos/${widget.controller!.productId}',
                ));
              }
            }, future: null,
          ),
        ),
      ),
    );
  }
}
