// groceries.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/groceries_controller.dart';
import 'package:shopi/views/home_page.dart';
import 'package:shopi/widget/item_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading for one second
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceriesController = Provider.of<GroceriesController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
                (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Groceries'),
        actions: [
          IconButton(
            onPressed: () => groceriesController.sortItemsAlphabetically(),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: groceriesController.groceries.length,
                itemBuilder: (context, index) {
                  final grocery = groceriesController.groceries[index];
                  final addedToCart =
                      groceriesController.addedGroceries[index] ?? false;
                  final isFavorite = groceriesController.isFavorite(index);

                  return CustomCard(
                    item: grocery,
                    isFavorite: isFavorite,
                    onFavoriteToggle: (isFav) =>
                        groceriesController.toggleFavorite(index),
                    onAddToCart: () async {
                      groceriesController.addToCart(context, index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            addedToCart
                                ? 'Added to cart'
                                : 'Item already in cart',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
