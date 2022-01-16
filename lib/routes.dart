import 'package:eco_slide_puzzle/puzzle/view/puzzle_page.dart';
import 'package:eco_slide_puzzle/screens/Landing/landing_screen.dart';
import 'package:eco_slide_puzzle/screens/Login/log_in_screen.dart';
import 'package:eco_slide_puzzle/screens/Sign%20up/sign_up_screen.dart';
import 'package:eco_slide_puzzle/screens/home/home.dart';
import 'package:eco_slide_puzzle/utils/authentication_wrapper.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here

final Map<String, WidgetBuilder> routes = {
  AuthenticationWrapper.routeName: (context) => const AuthenticationWrapper(),
  LandingScreen.routeName: (context) => const LandingScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LogInScreen.routeName: (context) => const LogInScreen(),
  Home.routeName: (context) => const Home(),
  Puzzle1.routeName: (context) =>
      const PuzzlePage(size: 3, imagePath: 'assets/images/owl/'),
  Puzzle2.routeName: (context) =>
      const PuzzlePage(size: 4, imagePath: 'assets/images/tester/'),
};

class Puzzle2 {
  static var routeName = '/puzzle2';
}

class Puzzle1 {
  static String routeName = '/puzzle1';
}
