import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

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
    Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 6,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          onSearch.call();
        },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          hintStyle: TextStyle(fontSize: size.height * 0.02),
          hintText: 'Buscar',
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          isDense: true,
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Icon(
              Icons.search,
              color: kPrimaryColor,
              size: size.height * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
