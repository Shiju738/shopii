// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/loading_controller.dart';
import 'package:shopi/controller/persional_care_controller.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:shopi/service/sql_lite.dart';
import 'package:shopi/views/home_page.dart';
import 'package:shopi/widget/item_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class PersonalCare extends StatefulWidget {
  const PersonalCare({Key? key}) : super(key: key);

  @override
  _PersonalCareState createState() => _PersonalCareState();
}

class _PersonalCareState extends State<PersonalCare> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final personalCareController = Provider.of<PersonalCareController>(context);
    final databaseHelper = DatabaseHelper();

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
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Personal Care'),
        actions: [
          IconButton(
            onPressed: () => personalCareController.sortItemsAlphabetically(),
            icon: const Icon(Icons.sort_by_alpha),
          ),
        ],
      ),
      body: Consumer<LoadingProvider>(
        builder: (context, loadingProvider, child) {
          return loadingProvider.isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 100,
                  ),
                )
              : GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount:
                      personalCareController.personalCareItems.length,
                  itemBuilder: (context, index) {
                    final item =
                        personalCareController.personalCareItems[index];
                    final isFavorite = item['isFavorite'] ?? false;

                    return CustomCard(
                      item: item,
                      isFavorite: isFavorite,
                      onFavoriteToggle: (isFav) =>
                          personalCareController.toggleFavorite(index),
                      onAddToCart: () async {
                        await databaseHelper.addItemToCart(
                          CartItem(
                            name: item['name'],
                            image: item['image'],
                            price: double.parse(
                                item['price'].replaceAll('\$', '')),
                            quantity: 1,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} added to cart.'),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}