import 'package:flutter/material.dart';

class BuyersScreen extends StatelessWidget {
  static const String id ='\buyer-screen';
  const BuyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Buyer"),
      ),
    );
  }
}