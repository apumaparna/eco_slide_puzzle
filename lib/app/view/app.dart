// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs

import 'package:eco_slide_puzzle/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:eco_slide_puzzle/l10n/l10n.dart';

import '../../puzzle/view/puzzle_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    Future<void>.delayed(const Duration(milliseconds: 20), () async {
      precacheImage(
        Image.asset('assets/images/shuffle_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_large.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_medium.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_small.png').image,
        context,
      );

      // load all the images for the owl
      for (int img = 0; img < 9; img++) {
        await precacheImage(
            Image.asset('assets/images/owl/$img.jpg').image, context);
      }

      // load all the images for the tester
      for (int img = 0; img < 15; img++) {
        await precacheImage(
            Image.asset('assets/images/tester/$img.jpg').image, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      // AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/puzzle1': (context) =>
            const PuzzlePage(size: 3, imagePath: 'assets/images/owl/'),
        '/puzzle2': (context) =>
            const PuzzlePage(size: 4, imagePath: 'assets/images/tester/'),
      },
      // home: const Home()
      //     const PuzzlePage(
      //   size: 3,
      //   imagePath: 'assets/images/owl/',
      // ),
    );
  }
}
