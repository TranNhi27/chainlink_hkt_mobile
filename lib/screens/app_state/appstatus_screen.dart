import 'package:flutter/material.dart';
import 'components/body.dart';

class AppStatus extends StatelessWidget {
  const AppStatus({Key? key}) : super(key: key);
  static String routeName ='/appState';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chainlink App Status"
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Body(),
    );
  }
}
