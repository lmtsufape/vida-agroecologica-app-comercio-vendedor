import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import '../../../shared/constants/app_text_constants.dart';
import '../../../shared/constants/style_constants.dart';
import '../../../shared/core/models/table_products_model.dart';

class ImageEdit extends StatefulWidget {
  final AddProductsController? controller;

  ImageEdit(this.controller, {Key? key}) : super(key: key);

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  int? _currentProductId;
  TableProductsModel? tableProductsModel;

  @override
  void initState() {
    super.initState();
    _currentProductId = widget.controller?.productId;
  }

  @override
  void didUpdateWidget(covariant ImageEdit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller?.productId != _currentProductId) {
      _currentProductId = widget.controller?.productId;
      tableProductsModel = widget.controller?.search(_currentProductId);
    }
    print(_currentProductId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (tableProductsModel == null || tableProductsModel?.imagem == null) {
      return Container(
        alignment: Alignment.center,
        height: size.width * 0.4,
        child: const AspectRatio(
          aspectRatio: 12 / 9,
          child: Material(
            elevation: 3,
            shadowColor: Colors.black,
            child: Icon(
              Icons.shopping_bag,
              size: 100,
              color: Colors.orange,
            ),
          ),
        ),
      );
    }

    String? base64Image = tableProductsModel?.imagem != null
        ? 'data:image/jpeg;base64,${base64Encode(tableProductsModel!.imagem!)}'
        : null;

    return Container(
      alignment: Alignment.center,
      height: size.width * 0.4,
      child: AspectRatio(
        aspectRatio: 12 / 9,
        child: Material(
          elevation: 3,
          shadowColor: Colors.black,
          child: Image.memory(base64Decode(base64Image!.split(',').last)),
        ),
      ),
    );
  }
}
