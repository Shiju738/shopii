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
import 'package:flutter/material.dart';

class MyHomePageS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageS> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomePainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.shopping_basket),
                      elevation: 0.1,
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.restaurant_menu)),
                        Container(
                          width: size.width * .20,
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.bookmark)),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.notifications)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BNBCustomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
