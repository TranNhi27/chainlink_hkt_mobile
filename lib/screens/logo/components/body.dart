import 'package:chainlink_project/screens/app_state/appstatus_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const AppStatus()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            color: Colors.white,
            child: Image.asset("assets/images/sos-logo.png")
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/chainlink.png", height: 48, width: 48,),
            Image.asset("assets/images/google.svg.png", height: 48, width: 48,),
            Image.asset("assets/images/transak.png", height: 48, width: 48,),
          ],
        )
      ],
    );
  }
}
