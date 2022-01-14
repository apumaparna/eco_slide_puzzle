// import 'package:eco_slide_puzzle/auth/authentication_service.dart';
import 'package:eco_slide_puzzle/constants.dart';
import 'package:eco_slide_puzzle/screens/home/home.dart';
// import 'package:eco_slide_puzzle/screens/Dashboard/dashboard_screen.dart';
// import 'package:eco_slide_puzzle/screens/home.dart';
import 'package:flutter/material.dart';
// import 'package:arc_app/size_config.dart';
// import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LogInCard extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LogInCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 25.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12.withAlpha(15),
                        labelText: "Email"),
                  ),
                  const Padding(padding: EdgeInsets.all(15.0)),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12.withAlpha(15),
                        labelText: "Password"),
                  ),
                  const Padding(padding: EdgeInsets.all(15.0)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Home.routeName);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 50.0),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: brightYellow,
                        shape: const StadiumBorder()),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
