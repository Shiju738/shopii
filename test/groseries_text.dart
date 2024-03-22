import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/controller/groceries_controller.dart';
class MockBuildContext extends Mock implements BuildContext {}
void main() {
  group("GroceriesController", () {
    late GroceriesController controller;
    late MockDatabaseHelper mockDatabaseHelper;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
      controller = GroceriesController(mockDatabaseHelper);
    });

    test('addToCart adds item to cart', () async {
      final testItem = {
        'image': 'images/apple.png',
        'name': 'Apple',
        'price': '\$1.99',
        'isFavorite': false,
      };
      const testIndex = 0;

      controller.addToCart(MockBuildContext(), testIndex);

      expect(mockDatabaseHelper.addItemToCartCalled, true);
      expect(
        mockDatabaseHelper.addedCartItem.name,
        testItem['name'],
      );
      expect(
        mockDatabaseHelper.addedCartItem.image,
        testItem['image'],
      );

      expect(mockDatabaseHelper.addedCartItem.quantity, 1);
    });
  });
}



