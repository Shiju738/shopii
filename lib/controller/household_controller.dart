// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/service/sql_lite.dart';

class HouseholdController extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _householdItems = [
    {
      'image': 'images/chair.png',
      'name': 'Chair',
      'price': '\$50',
      'isFavorite': false,
    },
    {
      'image': 'images/table.png',
      'name': 'Table',
      'price': '\$100',
      'isFavorite': false,
    },
    // Add more household items here
  ];

  List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get householdItems => _householdItems;

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  void addToCart(int index) async {
    await _databaseHelper.addItemToCart(
      CartItem(
        name: _householdItems[index]['name'],
        image: _householdItems[index]['image'],
        price: double.parse(_householdItems[index]['price'].replaceAll('\$', '')),
        quantity: 1,
      ),
    );
    // Notify listeners here if needed
  }

  void toggleFavorite(int index) {
    _householdItems[index]['isFavorite'] = !_householdItems[index]['isFavorite'];
    if (_householdItems[index]['isFavorite']) {
      _favoriteItems.add(_householdItems[index]);
    } else {
      _favoriteItems.remove(_householdItems[index]);
    }
    notifyListeners();
  }

  void sortItemsAlphabetically() {
    _householdItems.sort((a, b) => a['name'].compareTo(b['name']));
    notifyListeners();
  }
}
