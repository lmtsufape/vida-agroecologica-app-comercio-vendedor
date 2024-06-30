// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:thunderapp/screens/orders/orders_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';

class FileViewScreen extends StatelessWidget {
  final Uint8List comprovanteBytes;
  final PedidoModel model;
  final String comprovanteType;
  final OrdersController controller;


  const FileViewScreen({
    required this.model,
    required this.controller,
    required this.comprovanteBytes,
    required this.comprovanteType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: comprovanteType == 'pdf'
          ? PDFView(
        pdfData: comprovanteBytes,
      )
          : Center(
        child: Image.memory(comprovanteBytes),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed:() async {
            await controller.downloadComprovante(model.id!);
            if (controller.downloadPath != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Comprovante baixado com sucesso!'),
                    ),
              );
            }
          },
        child: const Icon(Icons.download, color: kTextColor,)),
    );
  }
}