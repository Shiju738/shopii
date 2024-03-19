import 'package:flutter/material.dart';

class PersonalCareController with ChangeNotifier {
  final List<Map<String, dynamic>> _personalCareItems = [
    {
      'image': 'images/shirt.png',
      'name': 'Shirt',
      'price': '\$20.00',
      'isFavorite': false,
    },
    {
      'image': 'images/pant.png',
      'name': 'Pant',
      'price': '\$30.00',
      'isFavorite': false,
    },
  ];

  final bool _isLoading = true; // Add isLoading property
  bool get isLoading => _isLoading; // Getter for isLoading

  List<Map<String, dynamic>> get personalCareItems => _personalCareItems;

  // Toggle the favorite status of an item
  void toggleFavorite(int index) {
    _personalCareItems[index]['isFavorite'] =
        !_personalCareItems[index]['isFavorite'];
    notifyListeners();
  }

  // Function to sort items alphabetically
  void sortItemsAlphabetically() {
    _personalCareItems.sort((a, b) => a['name'].compareTo(b['name']));
    notifyListeners();
  }

}
