import 'package:flutter/material.dart';
import 'package:chainlink_project/screens/logo/components/body.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({Key? key}) : super(key: key);
  static String routeName ='/logo';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}




