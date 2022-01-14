import 'package:eco_slide_puzzle/screens/Sign%20up/sign_up_card.dart';
// import 'package:arc_app/size_config.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/new_background_3.jpg'),
                    fit: BoxFit.cover)),
            child: SafeArea(
                child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: const [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 100.0, 0, 20.0),
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 4),
                                  blurRadius: (35.0),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ]),
                        ),
                      )),
                      SignUpCard()
                    ],
                  ),
                ),
              ),
            ))));
  }
}
