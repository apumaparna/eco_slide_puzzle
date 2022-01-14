import 'package:eco_slide_puzzle/constants.dart';
// import 'package:arc_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:eco_slide_puzzle/screens/Sign up/sign_up_screen.dart';
import 'package:eco_slide_puzzle/screens/Login/log_in_screen.dart';

class LandingScreenBody extends StatelessWidget {
  const LandingScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle buttonTextStyle =
        TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: pureWhite);

    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: brightPink,
        minimumSize: const Size(235, 70),
        shadowColor: darkestBlue,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/new_background_3.jpg'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: SizedBox(
                width: double.infinity,
                child: Column(children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Column(children: <Widget>[
                        const SizedBox(
                          height: 150,
                        ),
                        const Spacer(),
                        const Text("Welcome to the Slider Puzzle Game!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                color: pureWhite,
                                // ignore: prefer_const_literals_to_create_immutables
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 35.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )
                                ])),
                        const Spacer(),
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                                style: style,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, LogInScreen.routeName);
                                },
                                child: const Text("LOG IN",
                                    style: buttonTextStyle)),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                                style: style,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignUpScreen.routeName);
                                },
                                child: const Text("SIGN UP",
                                    style: buttonTextStyle))
                          ],
                        ),
                        const Spacer()
                      ]))
                ]))));
  }
}
