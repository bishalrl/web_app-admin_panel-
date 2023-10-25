import 'package:ecommerce/screens/landing.dart';
import 'package:ecommerce/screens/web_screen/web_login.dart';
import 'package:flutter/material.dart';

class Layout_Screen extends StatelessWidget {
  const Layout_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const WebLogin();
      }
      return const LandingScreen();
    });
  }
}
