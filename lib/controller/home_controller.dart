// home_controller.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/model/cart_model.dart';

class HomeController extends ChangeNotifier {
  int _bottomNavIndex = 0;

  int get bottomNavIndex => _bottomNavIndex;

  set bottomNavIndex(int index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  Future<List<CartItem>> getCartItems(BuildContext context) async {
    CartController cartController = Provider.of<CartController>(context, listen: false);
    return await cartController.getCartItems();
  }
}
