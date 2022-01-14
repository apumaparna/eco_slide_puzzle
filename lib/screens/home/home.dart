// import 'package:flutter/cupertino.dart';
import 'package:eco_slide_puzzle/routes.dart';
import 'package:eco_slide_puzzle/screens/Landing/landing_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static var routeName = '/home';

  //  final title;

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(50.0)));
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      // ),
      body: Center(
          child: Column(children: <Widget>[
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Puzzle1.routeName);
                  },
                  child: const Text('Puzzle 1'),
                  style: style,
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Puzzle2.routeName);
                    },
                    child: const Text('Puzzle 2'),
                    style: style)),
          ],
        ),
        const Spacer(),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LandingScreen.routeName);
            },
            child: const Text('LOG OUT')),
        const Spacer(),
      ])),
    );
  }
}
