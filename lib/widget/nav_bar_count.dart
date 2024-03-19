import 'package:flutter/material.dart';
import 'package:shopi/controller/home_controller.dart';
import 'package:shopi/model/cart_model.dart';
// Import your controller class

class CartItemCountWidget extends StatelessWidget {
  final HomeController controller;

  const CartItemCountWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: controller.getCartItems(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const SizedBox();
        } else {
          final cartItems = snapshot.data ?? [];
          final itemCount = cartItems.fold<int>(
            0,
            (previousValue, element) => previousValue + element.quantity,
          );
          return itemCount > 0
              ? Positioned(
                  bottom: 10,
                  width: 19,
                  left: 9,
                  top: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      '$itemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        }
      },
    );
  }
}
