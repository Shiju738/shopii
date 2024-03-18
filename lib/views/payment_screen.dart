import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final String totalPrise;
  const PaymentScreen({Key? key, required this.totalPrise}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'ATM Card Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white, // Text color on gradient background
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Type',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Label text color on gradient background
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Label text color on gradient background
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            labelStyle: TextStyle(
                                color: Colors
                                    .white), // Label text color on gradient background
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            labelStyle: TextStyle(
                                color: Colors
                                    .white), // Label text color on gradient background
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Total Price
            const Text(
              'Total Price:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: widget.totalPrise,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            // Payment Button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
