import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSearch;

  const ProductSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 0,
      child: TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          onSearch.call();
        },
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: size.height * 0.015),
          hintText: 'Buscar por produto',
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          isDense: true,
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Icon(
              Icons.search,
              size: size.height * 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
