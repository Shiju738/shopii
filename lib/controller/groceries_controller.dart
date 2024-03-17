// groceries_controller.dart

// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/service/sql_lite.dart';

class GroceriesController extends ChangeNotifier {
  List<Map<String, dynamic>> groceries = [
    {
      'image': 'images/apple.png',
      'name': 'Apple',
      'price': '\$1.99',
      'isFavorite': false
    },
    {
      'image': 'images/banana.png',
      'name': 'Banana',
      'price': '\$0.99',
      'isFavorite': false
    },
  ];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Map<int, bool> addedGroceries = {}; // Track added groceries

  DatabaseHelper _databaseHelper = DatabaseHelper();

  void addToCart(BuildContext context, int index) async {
    final item = groceries[index];
    final cartItem = CartItem(
      name: item['name'],
      image: item['image'],
      price: double.parse(item['price'].replaceAll('\$', '')),
      quantity: 1,
    );
    await _databaseHelper.addItemToCart(cartItem);
    addedGroceries[index] = true;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    groceries[index]['isFavorite'] = !groceries[index]['isFavorite'];
    notifyListeners();
  }

  void sortItemsAlphabetically() {
    groceries.sort((a, b) => a['name'].compareTo(b['name']));
    notifyListeners();
  }

  bool isFavorite(int index) {
    return groceries[index]['isFavorite'];
  }

  
}
