import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/cart_controller.dart';
import 'package:shopi/controller/groceries_controller.dart';
import 'package:shopi/controller/home_controller.dart';
import 'package:shopi/controller/loading_controller.dart';
import 'package:shopi/controller/persional_care_controller.dart';
import 'package:shopi/controller/search_controller.dart';
import 'package:shopi/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GroceriesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonalCareController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchControllers(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
