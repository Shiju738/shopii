
class ItemController {
  final List<Map<String, dynamic>> _groceries = [
    {
      'image': 'images/apple.png',
      'name': 'Apple',
      'price': '\$1.99',
      'isFavorite': false
    },
    {
      'image': 'images/banana.png',
      'name': 'Banana',
      'price': '\$0.99',
      'isFavorite': false
    },
  ];

  final List<Map<String, dynamic>> _householdItems = [
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

  List<Map<String, dynamic>> get allItems {
    return [..._groceries, ..._householdItems, ..._personalCareItems];
  }

  List<Map<String, dynamic>> searchItems(String query) {
    List<Map<String, dynamic>> searchedItems = [];
    final allItems = this.allItems;
    for (var item in allItems) {
      if (item['name'].toLowerCase().contains(query.toLowerCase())) {
        searchedItems.add(item);
      }
    }
    return searchedItems;
  }
}
