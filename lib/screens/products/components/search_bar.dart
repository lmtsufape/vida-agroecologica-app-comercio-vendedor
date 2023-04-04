import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSearch;
  const SearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          onSearch.call();
        },
        controller: controller,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFFFFFFF),
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(30))),
          hintText: 'Pesquisar',
          contentPadding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 15),
          isDense: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue,
            size: 25,
          ),
        ),
      ),
    );
  }
}
