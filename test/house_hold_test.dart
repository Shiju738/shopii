// home_controller_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/controller/sample.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/controller/home_controller.dart';
// Import the mock class

void main() {
 group('HomeController', () {
    test('getCartItems returns correct items', () async {
      // Arrange
      final mockCartController = MockCartController();
      final cartItems = [CartItem(id: 1, name: 'Test Item', price: 10.0, image: '', quantity: 1)];
      when(mockCartController.getCartItems()).thenAnswer((_) async => cartItems);
      final homeController = HomeController();
      final context = Provider<CartController>.value(
        value: mockCartController,
        child: Container(), // This is just a placeholder for the context
      );

      // Act
      final result = await homeController.getCartItems(context as BuildContext);

      // Assert
      expect(result, equals(cartItems));
      verify(mockCartController.getCartItems()).called(1);
    });
 });
}
