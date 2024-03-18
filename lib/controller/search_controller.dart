import 'package:flutter/material.dart';
import 'package:shopi/model/list.dart';

class SearchControllers extends ChangeNotifier {
  final ItemController itemController = ItemController();

  List<Map<String, dynamic>> filteredProducts = [];
  bool _showList = false;

  bool get showList => _showList;

  void searchItems(String query) {
    filteredProducts = itemController.searchItems(query);
    _showList = query.isNotEmpty;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    filteredProducts[index]['isFavorite'] =
        !filteredProducts[index]['isFavorite'];
    notifyListeners();
  }
}
