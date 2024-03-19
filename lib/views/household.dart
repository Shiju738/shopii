// household.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/household_controller.dart';
import 'package:shopi/views/home_page.dart';
import 'package:shopi/widget/item_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Household extends StatefulWidget {
  const Household({Key? key}) : super(key: key);

  @override
  _HouseholdState createState() => _HouseholdState();
}

class _HouseholdState extends State<Household> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HouseholdController(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Household'),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<HouseholdController>(context, listen: false)
                    .sortItemsAlphabetically();
              },
              icon: const Icon(Icons.sort_by_alpha),
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 100,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<HouseholdController>(
                  builder: (context, controller, _) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: controller.householdItems.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        item: controller.householdItems[index],
                        isFavorite: controller.householdItems[index]
                            ['isFavorite'],
                        onFavoriteToggle: (isFavorite) {
                          controller.toggleFavorite(index);
                        },
                        onAddToCart: () {
                          controller.addToCart(index);
                        },
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
