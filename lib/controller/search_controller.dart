import 'package:flutter/material.dart';
import 'package:shopi/model/list.dart'; // Assuming you have a model named 'ItemController'

class SearchControllers extends ChangeNotifier {
  final ItemController _itemController = ItemController();
  List<Map<String, dynamic>> _filteredProducts = [];

  List<Map<String, dynamic>> get filteredProducts => _filteredProducts;

  void searchItems(String query) {
    _filteredProducts = _itemController.searchItems(query);
    notifyListeners();
  }
}
