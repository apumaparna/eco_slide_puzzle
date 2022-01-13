// import 'package:flutter/cupertino.dart';
import 'package:eco_slide_puzzle/puzzle/puzzle.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //  final title;

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(50.0)));
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const PuzzlePage(
                              size: 3, imagePath: 'assets/images/owl/'))));
                },
                child: const Text('Puzzle 1'),
                style: style,
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const PuzzlePage(
                                size: 4, imagePath: 'assets/images/tester/'))));
                  },
                  child: const Text('Puzzle 2'),
                  style: style)),
        ],
      )),
    );
  }
}
