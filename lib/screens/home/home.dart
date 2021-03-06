// import 'package:flutter/cupertino.dart';
import 'package:eco_slide_puzzle/routes.dart';
import 'package:eco_slide_puzzle/screens/Landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_slide_puzzle/utils/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Puzzle0.routeName);
                      },
                      child: const Text('Basic'),
                      style: style,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Puzzle1.routeName);
                      },
                      child: const Text('Intermediate'),
                      style: style,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Puzzle2.routeName);
                        },
                        child: const Text('Advance'),
                        style: style)),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LeaderBoard.routeName);
                        },
                        child: const Text('Leader'),
                        style: style)),
              ],
            )),
        const Spacer(),
        ElevatedButton(
            onPressed: () async {
              return context
                  .read<AuthenticationService>()
                  .signOut()
                  .then((success) {
                if (success) {
                  Navigator.pushNamed(context, LandingScreen.routeName);
                }
              });
            },
            child: const Text('LOG OUT')),
        const Spacer(),
      ])),
    );
  }
}
