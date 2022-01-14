// import 'package:arc_app/size_config.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:eco_slide_puzzle/constants.dart';
import 'package:eco_slide_puzzle/screens/home/home.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({Key? key}) : super(key: key);

  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  // final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    // final ref = fb.reference();

    return Card(
        elevation: 25.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: signUpFormKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12.withAlpha(15),
                            labelText: "Email"),
                      ),
                      const Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12.withAlpha(15),
                            labelText: "Username"),
                      ),
                      const Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12.withAlpha(15),
                            labelText: "Create a Password"),
                      ),
                      const Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12.withAlpha(15),
                            labelText: "Confirm Password"),
                      ),
                      const Padding(padding: EdgeInsets.all(15.0)),
                      TextButton(
                        onPressed: () {
                          if (signUpFormKey.currentState!.validate()) {
                            Navigator.pushNamed(context, Home.routeName);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: (2.0), horizontal: (50.0)),
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(fontSize: (16.0)),
                          ),
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: brightYellow,
                            shape: const StadiumBorder()),
                      )
                    ])))
          ]),
        ));
  }
}
