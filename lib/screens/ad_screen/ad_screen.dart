import 'package:flutter/material.dart';
import 'components/body.dart';

class Admod extends StatefulWidget {
  const Admod({Key? key}) : super(key: key);
  static String routeName ='/admod';

  @override
  State<Admod> createState() => _AdmodState();
}

class _AdmodState extends State<Admod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Admod demo"
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Body(title: 'Hi',),
    );
  }
}
