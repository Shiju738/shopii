import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  // Define the current page variable
  String _currentPage = 'Home';

  // Getter for current page
  String get currentPage => _currentPage;

  // Function to navigate to a different page
  void navigateTo(String page) {
    _currentPage = page;
    notifyListeners(); 
  }
}
