// ignore_for_file: prefer_final_fields
class CartItem {
  final int? id;
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
