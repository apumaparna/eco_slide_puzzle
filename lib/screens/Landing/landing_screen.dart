import 'package:eco_slide_puzzle/screens/Landing/landing_screen_body.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static String routeName = "/landing";

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LandingScreenBody(),
    );
  }
}
