// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Personal Care'),
            ),
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 100,
              ),
            ),
          )
        : _buildPersonalCareContent(context);
  }

  Widget _buildPersonalCareContent(BuildContext context) {
    final personalCareController = Provider.of<PersonalCareController>(context);
    final DatabaseHelper databaseHelper = DatabaseHelper();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: personalCareController.personalCareItems.length,
          itemBuilder: (context, index) {
            final item = personalCareController.personalCareItems[index];
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
                    price: double.parse(item['price'].replaceAll('\$', '')),
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
        ),
      ),
    );
  }
}
