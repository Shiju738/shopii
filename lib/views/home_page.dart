import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/home_controller.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/views/cart.dart';
import 'package:shopi/views/groceries.dart';
import 'package:shopi/views/household.dart';
import 'package:shopi/views/personal_care.dart';
import 'package:shopi/views/search.dart';
import 'package:shopi/widget/home_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(context);

    return Scaffold(
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
        currentIndex: homeController.bottomNavIndex,
        onTap: (index) {
          homeController.bottomNavIndex = index;
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
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
            icon: Consumer<HomeController>(
              builder: (context, controller, _) {
                return Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    FutureBuilder<List<CartItem>>(
                      future: controller.getCartItems(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        } else if (snapshot.hasError) {
                          return const SizedBox();
                        } else {
                          final cartItems = snapshot.data ?? [];
                          final itemCount = cartItems.fold<int>(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.quantity);
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
                    ),
                  ],
                );
              },
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.search_off),
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
