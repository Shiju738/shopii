// cart_controller.dart
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:shopi/model/cart_model.dart'; // Assuming you have CartItem model
import 'package:shopi/service/sql_lite.dart'; // Assuming you have DatabaseHelper class

class CartController extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  List<CartItem> _cartItems = [];

  CartController({DatabaseHelper? databaseHelper}) {
    _databaseHelper = databaseHelper ?? DatabaseHelper();
    _initializeCartItems();
  }
  List<CartItem> get cartItems => _cartItems;
  int get totalItems => _cartItems.length;

  double get totalPrice {
    return _cartItems.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price * element.quantity,
    );
  }

  Future<void> _initializeCartItems() async {
    _cartItems = await getCartItems();
    notifyListeners();
  }

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
    _cartItems = List.generate(
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
    notifyListeners(); // Notify listeners after cart items are fetched
    return _cartItems;
  }

  Future<void> clearCart() async {
    final db = await _databaseHelper.database;
    await db.delete(DatabaseHelper.cartTable);
    _cartItems.clear();
    notifyListeners();
  }
}

class MockDatabaseHelper extends Mock implements DatabaseHelper {
  bool addItemToCartCalled = false;
  late CartItem addedCartItem;

  @override
  Future<void> addItemToCart(CartItem cartItem) async {
    addItemToCartCalled = true;
    addedCartItem = cartItem;
  }
}