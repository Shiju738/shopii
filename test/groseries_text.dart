import 'package:flutter_test/flutter_test.dart';
import 'package:shopi/controller/groceries_controller.dart';

void main() {
  group('GroceriesController', () {
    test('Initial groceries list is not empty', () {
      final controller = GroceriesController();
      expect(controller.groceries.isNotEmpty, true);
    });
    test(' favorite updates isFavorite property', () {
      final controller = GroceriesController();
      final initialFavorite = controller.isFavorite(0);
      controller.toggleFavorite(0);
      final toggledFavorite = controller.isFavorite(0);
      expect(toggledFavorite, !initialFavorite);
    });
    test('Sorting items alphabetically updates groceries list', () {
      final controller = GroceriesController();
      final initialList = List.from(controller.groceries);
      controller.sortItemsAlphabetically();
      final sortedList = List.from(controller.groceries);
      initialList.sort((a, b) => a['name'].compareTo(b['name']));
      expect(sortedList, initialList);
    });
  });
}
