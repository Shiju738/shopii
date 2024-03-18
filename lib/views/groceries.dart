// groceries.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import your GroceriesController class
import 'package:shopi/controller/groceries_controller.dart';
import 'package:shopi/controller/loading_controller.dart';
import 'package:shopi/widget/item_card.dart';
import 'home_page.dart'; // Import your HomePage class
// Import your ItemCard class
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {

  @override
  void initState() {
    super.initState();
    // Access the LoadingProvider instance
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    // Simulate loading for one second
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        // Set loading to false when loading is complete
        loadingProvider.setLoading(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the LoadingProvider instance
    final loadingProvider = Provider.of<LoadingProvider>(context);

    final groceriesController = Provider.of<GroceriesController>(context);

    return Scaffold(
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
        title: const Text('Groceries'),
        actions: [
          IconButton(
            onPressed: () => groceriesController.sortItemsAlphabetically(),
            icon: const Icon(Icons.sort_by_alpha),
          ),
        ],
      ),
      body: loadingProvider.isLoading
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
