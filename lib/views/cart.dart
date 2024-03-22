// cart_page.dart
// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/controller/loading_controller.dart';
import 'package:shopi/views/home_page.dart'; 
import 'package:shopi/widget/card.dart';
import 'payment_screen.dart'; 

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
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
  void initState() {
    super.initState();

    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    loadingProvider.setLoading(true);

    Timer(const Duration(seconds: 2), () {
      setState(() {
        loadingProvider.setLoading(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, _) {
        final cartItems = cartController.cartItems;

        // Access the LoadingProvider instance
        final loadingProvider = Provider.of<LoadingProvider>(context);

        return loadingProvider.isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 100,
                ),
              )
            : cartItems.isEmpty
                ? const Center(
                    child: Text('Your cart is empty.'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return CartItemCard(item: item);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Total Items: ${cartItems.length}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  totalPrise:
                                      ' \$${cartController.totalPrice.toStringAsFixed(2)}',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(fontSize: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
      },
    );
  }
}
