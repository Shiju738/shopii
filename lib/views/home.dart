// // Main MyApp class
// // ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopi/controller/cart_controller.dart';
// import 'package:shopi/controller/home_controller.dart';
// import 'package:shopi/model/cart_model.dart';
// import 'package:shopi/views/cart.dart';
// import 'package:shopi/views/groceries.dart';
// import 'package:shopi/views/household.dart';
// import 'package:shopi/views/personal_care.dart';

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => HomeController(), // Provide the HomeController
//       child: _MyHomePage(),
//     );
//   }
// }

// class _MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final homeController = Provider.of<HomeController>(context);

//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//         color: const Color.fromARGB(255, 104, 103, 103),
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: const Icon(
//                 Icons.home,
//                 color: Colors.white,
//               ),
//               onPressed: () => homeController.navigateTo('Home'),
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.people,
//                 color: Colors.white,
//               ),
//               onPressed: () => homeController.navigateTo('People'),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.notifications,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.settings,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Stack(
//               children: [
//                 const Icon(
//                   Icons.shopping_bag_rounded,
//                   size: 45,
//                   color: Color.fromARGB(255, 9, 9, 9),
//                 ),
//                 Consumer<CartController>(
//                   builder: (context, cartController, _) {
//                     return FutureBuilder<List<CartItem>>(
//                       future: cartController.getCartItems(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           // Loading state
//                           return const CircularProgressIndicator();
//                         } else if (snapshot.hasError) {
//                           // Error state
//                           return const Text('Error loading cart items');
//                         } else {
//                           // Success state
//                           final cartItems = snapshot.data ?? [];
//                           final itemCount = cartItems.fold<int>(
//                               0,
//                               (previousValue, element) =>
//                                   previousValue + element.quantity);
//                           return itemCount > 0
//                               ? Positioned(
//                                   right: 0,
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     radius: 10,
//                                     child: Text(
//                                       '$itemCount',
//                                       style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 255, 252, 252),
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : const SizedBox();
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CartPage(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () => homeController.navigateTo('Home'),
//                     child: const Text('Household'),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => homeController.navigateTo('Groceries'),
//                     child: const Text('Groceries'),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => homeController.navigateTo('Personal Care'),
//                     child: const Text('Personal Care'),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: _buildPage(homeController.currentPage),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPage(String page) {
//     switch (page) {
//       case 'Home':
//         return const Household();
//       case 'Groceries':
//         return const Groceries();
//       case 'Personal Care':
//         return const PersonalCare();
//       default:
//         return Container();
//     }
//   }
// // }



//shoping cart icon functin down


// Consumer<CartController>(
//                   builder: (context, cartController, _) {
//                     return Stack(
//                       children: [
//                         const Icon(Icons.shopping_cart),
//                         if (cartController.cartItems.isNotEmpty)
//                           Positioned(
//                             right: 0,
//                             left: 3,
//                             child: CircleAvatar(
//                               radius: 8,
//                               backgroundColor: Colors.red,
//                               foregroundColor: Colors.white,
//                               child: Text(
//                                 '${cartController.cartItems.length}',
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                 ),


//  IconButton(
//             icon: Stack(
//               children: [
//                 const Icon(
//                   Icons.shopping_cart,
//                   size: 45,
//                   color: Color.fromARGB(255, 57, 56, 56),
//                 ),
//                 Consumer<CartController>(
//                   builder: (context, cartController, _) {
//                     return FutureBuilder<List<CartItem>>(
//                       future: cartController.getCartItems(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           // Loading state
//                           return const CircularProgressIndicator();
//                         } else if (snapshot.hasError) {
//                           // Error state
//                           return const Text('Error loading cart items');
//                         } else {
//                           // Success state
//                           final cartItems = snapshot.data ?? [];
//                           final itemCount = cartItems.fold<int>(
//                               0,
//                               (previousValue, element) =>
//                                   previousValue + element.quantity);
//                           return itemCount > 0
//                               ? Positioned(
//                                   right: 0,
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     radius: 10,
//                                     child: Text(
//                                       '$itemCount',
//                                       style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 255, 252, 252),
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : const SizedBox();
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CartPage(),
//                 ),
//               );
//             },
//           ),