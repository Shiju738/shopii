import 'package:flutter/material.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/service/sql_lite.dart';

class CartController extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  List<CartItem> _cartItems = [];

  CartController() {
    _databaseHelper = DatabaseHelper();
    _initializeCartItems();
  }

 
  List<CartItem> get cartItems => _cartItems;

 
  Future<void> _initializeCartItems() async {
    _cartItems = await getCartItems();
    notifyListeners();
  }

// Method to add an item to the cart
  Future<void> addToCart(CartItem item) async {
    final db = await _databaseHelper.database;
    final existingItemIndex =
        _cartItems.indexWhere((element) => element.id == item.id);

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += 1;
      await db.update(
        DatabaseHelper.cartTable,
        _cartItems[existingItemIndex].toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      await db.insert(DatabaseHelper.cartTable, item.toMap());
      _cartItems.add(item);
    }
    _cartItems = await getCartItems();
    notifyListeners();
  }

// Method to remove an item from the cart
  Future<void> removeFromCart(CartItem item) async {
    final db = await _databaseHelper.database;
    if (item.quantity > 1) {
      item.quantity -= 1;
      await db.update(
        DatabaseHelper.cartTable,
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      await db.delete(
        DatabaseHelper.cartTable,
        where: 'id = ?',
        whereArgs: [item.id],
      );
    }
    _cartItems = await getCartItems();
    notifyListeners();
  }

 
  Future<List<CartItem>> getCartItems() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(DatabaseHelper.cartTable);
    return List.generate(
      maps.length,
      (i) {
        return CartItem(
          id: maps[i]['id'],
          name: maps[i]['name'],
          price: maps[i]['price'],
          quantity: maps[i]['quantity'],
          image: maps[i]['image'],
        );
      },
    );
  }

 
  Future<void> clearCart() async {
    final db = await _databaseHelper.database;
    await db.delete(DatabaseHelper.cartTable);
    _cartItems.clear();
    notifyListeners();
  }
}
