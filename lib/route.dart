import 'package:chainlink_project/screens/ad_screen/ad_screen.dart';
import 'package:chainlink_project/screens/app_state/appstatus_screen.dart';
import 'package:chainlink_project/screens/logo/logo_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LogoScreen.routeName: (context) => const LogoScreen(),
  AppStatus.routeName: (context) => const AppStatus(),
  Admod.routeName: (context) => const Admod(),
};