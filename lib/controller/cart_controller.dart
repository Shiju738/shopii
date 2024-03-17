import 'package:flutter/material.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/service/sql_lite.dart';

class CartController extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  List<CartItem> _cartItems = []; // New private variable to hold cart items

  CartController() {
    _databaseHelper = DatabaseHelper();
    _initializeCartItems(); // Initialize cart items from the database
  }

  // Getter to access cart items
  List<CartItem> get cartItems => _cartItems;

  // Method to initialize cart items from the database
  Future<void> _initializeCartItems() async {
    _cartItems = await getCartItems();
    notifyListeners();
  }

  // Method to add an item to the cart
  Future<void> addToCart(CartItem item) async {
    final db = await _databaseHelper.database;
    // Check if the item is already in the cart
    final existingItemIndex =
        _cartItems.indexWhere((element) => element.id == item.id);

    if (existingItemIndex != -1) {
      // If the item is already in the cart, increase its quantity
      _cartItems[existingItemIndex].quantity += 1;
      await db.update(
        DatabaseHelper.cartTable,
        _cartItems[existingItemIndex].toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      // If the item is not in the cart, add it
      await db.insert(DatabaseHelper.cartTable, item.toMap());
      _cartItems.add(item); // Update the local list
    }
    notifyListeners(); // Notify listeners after adding to cart
  }

  // Method to remove an item from the cart
  Future<void> removeFromCart(CartItem item) async {
    final db = await _databaseHelper.database;
    if (item.quantity > 1) {
      // If quantity > 1, decrease quantity
      item.quantity -= 1;
      await db.update(
        DatabaseHelper.cartTable,
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      // If quantity = 1, remove item from cart
      await db.delete(
        DatabaseHelper.cartTable,
        where: 'id = ?',
        whereArgs: [item.id],
      );
      _cartItems.removeWhere(
          (element) => element.id == item.id); // Update the local list
    }
    notifyListeners(); // Notify listeners after removing from cart
  }

  // Method to get cart items from the database
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

  // Method to clear the cart
  Future<void> clearCart() async {
    final db = await _databaseHelper.database;
    await db.delete(DatabaseHelper.cartTable);
    _cartItems.clear(); // Clear the local list
    notifyListeners(); // Notify listeners after clearing cart
  }
}
