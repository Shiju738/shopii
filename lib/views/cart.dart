// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/views/home_page.dart';
import 'package:shopi/widget/card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const MyHomePage(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        title: const Text('Cart'),
      ),
      body: const CartItemList(),
    );
  }
}

class CartItemList extends StatefulWidget {
  const CartItemList({Key? key}) : super(key: key);

  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return FutureBuilder<List<CartItem>>(
      future: cartController.getCartItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Your cart is empty.'),
          );
        } else {
          double totalPrice = snapshot.data!
              .map((item) => item.price * item.quantity)
              .reduce((value, element) => value + element);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return CartItemCard(item: item);
                  },
                ),
              ),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Payment(),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
