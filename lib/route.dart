import 'package:chainlink_project/screens/ad_screen/ad_screen.dart';
import 'package:chainlink_project/screens/app_state/appstatus_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  AppStatus.routeName: (context) => const AppStatus(),
  Admod.routeName: (context) => const Admod(),
};