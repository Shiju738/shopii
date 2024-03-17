// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/views/cart.dart';
import 'package:shopi/views/groceries.dart';
import 'package:shopi/views/household.dart';
import 'package:shopi/views/personal_care.dart';
import 'package:shopi/widget/home_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CategoryCard(
                  imagePath: 'images/household.png',
                  title: 'Household',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Household(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: CategoryCard(
                  imagePath: 'images/Groceries.png',
                  title: 'Groceries',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Groceries(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: CategoryCard(
                  imagePath: 'images/persional care.png',
                  title: 'Personal Care',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalCare(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          // Navigate to the cart page when the "Cart" icon is tapped
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartController>(
              builder: (context, cartController, _) {
                return Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    FutureBuilder<List<CartItem>>(
                      future: cartController.getCartItems(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Loading state
                          return const SizedBox();
                        } else if (snapshot.hasError) {
                          // Error state
                          return const SizedBox();
                        } else {
                          // Success state
                          final cartItems = snapshot.data ?? [];
                          final itemCount = cartItems.fold<int>(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.quantity);
                          return itemCount > 0
                              ? Positioned(
                                  bottom: 10,
                                  width: 19,
                                  // Adjust the position as needed
                                  left: 9,
                                  top: 1, // Adjust the position as needed
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
                    ),
                  ],
                );
              },
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
