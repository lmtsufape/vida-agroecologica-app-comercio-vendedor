import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/table_products_model.dart';

class ImageCardList extends StatefulWidget {
  final String userToken;
  final int? productId; // Adiciona o ID do produto como argumento
  final List<TableProductsModel> tableProducts;

  const ImageCardList(
    this.userToken,
    this.productId,
    this.tableProducts,
    {Key? key}) : super(key: key);

  @override
  State<ImageCardList> createState() => _ImageCardListState();
}

class _ImageCardListState extends State<ImageCardList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(

      future: Future.value(searchID(widget.productId, widget.tableProducts)), // Retorna uma instância de Future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // O futuro ainda está sendo processado, você pode mostrar um indicador de carregamento aqui
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Ocorreu um erro durante o processamento do futuro
          return Text("Erro: ${snapshot.error}");
        } else if (snapshot.data == null) {
          // O produto não foi encontrado na lista
          return const AspectRatio(
            aspectRatio: 1.15,
            child: Material(
              elevation: 1.3,
              shadowColor: Colors.black,
              child: Icon(
                Icons.shopping_bag,
                size: 80,
                color: kPrimaryColor,
              ),
            ),
          );
        } else {
          // O produto foi encontrado na lista, e snapshot.data contém o valor de produtoIndex
          int produtoIndex = snapshot.data!;
          String? base64Image = widget.tableProducts[produtoIndex].imagem != null
              ? 'data:image/jpeg;base64,${base64Encode(widget.tableProducts[produtoIndex].imagem!)}'
              : null;

          return AspectRatio(
            aspectRatio: 1.05,
            child: SizedBox(
              child: Material(
                
                shadowColor: Colors.black,
                elevation: 3,
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.tableProducts[produtoIndex].imagem != null && base64Image != null
                      ? Image.memory(base64Decode(base64Image.split(',').last))
                      : const Icon(
                    Icons.shopping_bag,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

int? searchID(int? index, List<TableProductsModel> list){
  for(int i = 0; i < list.length; i++){
    if(list[i].id == index){
      print(i);
      return i;
    }
  }
  return null;
}