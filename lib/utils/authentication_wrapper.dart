import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/Landing/landing_screen.dart';
import '../screens/home/home.dart';

class AuthenticationWrapper extends StatelessWidget {
  static String routeName = "/auth";
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Home();
    }

    return const LandingScreen();
  }
}
