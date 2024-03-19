import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/home_controller.dart';
import 'package:shopi/views/cart.dart';
import 'package:shopi/views/groceries.dart';
import 'package:shopi/views/household.dart';
import 'package:shopi/views/personal_care.dart';
import 'package:shopi/views/search.dart';
import 'package:shopi/widget/home_card.dart';
import 'package:shopi/widget/nav_bar_count.dart'; // Import the custom widget

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
                    const Icon(Icons.shopping_cart, size: 30),
                    CartItemCountWidget(controller: controller), 
                  ],
                );
              },
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.search_off),
            icon: Icon(Icons.search, size: 30),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
