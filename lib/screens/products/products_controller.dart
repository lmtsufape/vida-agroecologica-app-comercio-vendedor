import 'package:flutter/material.dart';

class ProductsController with ChangeNotifier {
  final TextEditingController _searchController =
      TextEditingController();

  TextEditingController get searchController =>
      _searchController;
}
