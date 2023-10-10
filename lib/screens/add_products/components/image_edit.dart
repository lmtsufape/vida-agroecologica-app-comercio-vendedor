import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import '../../../shared/constants/app_text_constants.dart';

class ImageEdit extends StatefulWidget {
  final AddProductsController? controller;

  ImageEdit(this.controller, {Key? key}) : super(key: key);

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  bool _loading = true;
  int? _currentProductId; // Armazena o ID do produto atualmente selecionado.

  @override
  void initState() {
    super.initState();
    _currentProductId = widget.controller?.productId;
    _loadImage();
  }

  // O método didUpdateWidget é chamado sempre que o widget pai reconstruir o widget ImageEdit.
  @override
  void didUpdateWidget(covariant ImageEdit oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller?.productId != _currentProductId) {
      // O ID do produto foi alterado, então recarregue a imagem.
      _currentProductId = widget.controller?.productId;
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    try {
      widget.controller!.setHasImage(await widget.controller!.boolImage(_currentProductId));
      setState(() {
        _loading = false;
      });
    } catch (e) {
      // Handle the error here
      print("Error loading image: $e");
      setState(() {
        _loading = false;
      });
    }
  }

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
          child: _loading
              ? CircularProgressIndicator() // Display a loading indicator while loading the image.
              : widget.controller?.hasImage ?? false
              ? Image.network(
            '$kBaseURL/produtos/$_currentProductId/imagem',
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer ${widget.controller?.token}"
            },
          )
              : Icon(
            Icons.shopping_bag,
            size: 100,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}