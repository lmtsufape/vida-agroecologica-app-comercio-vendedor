import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:thunderapp/shared/core/models/products_model.dart';
import '../../../shared/core/models/table_products_model.dart';
import '../edit_products_controller.dart';

class ImageEdit extends StatefulWidget {
  final EditProductsController? controller;
  final ProductsModel model;

  ImageEdit(this.controller, this.model, {Key? key})
      : super(key: key);

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  TableProductsModel? tableProductsModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tableProductsModel = widget.controller
        ?.search(widget.model.produtoTabeladoId);
    Size size = MediaQuery.of(context).size;
    if (tableProductsModel == null ||
        tableProductsModel?.imagem == null) {
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
          child: Image.memory(
              base64Decode(base64Image!.split(',').last)),
        ),
      ),
    );
  }
}
