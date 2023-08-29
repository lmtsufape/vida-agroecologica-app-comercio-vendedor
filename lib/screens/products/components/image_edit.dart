import 'package:flutter/material.dart';
import 'package:thunderapp/screens/products/products_controller.dart';
import '../../../shared/constants/app_text_constants.dart';

// ignore: must_be_immutable
class ImageEdit extends StatefulWidget {
  ProductsController? controller;
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
        aspectRatio: 12 / 9,
        child: Material(
          elevation: 3,
          shadowColor: Colors.black,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (widget.controller!.productId == null) {
                return const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.orange,
                );
              } else {
                return Image(
                    image: NetworkImage(
                  '$kBaseURL/produtos/${widget.controller!.productId}/imagem',
                ));
              }
            },
            future: null,
          ),
        ),
      ),
    );
  }
}
