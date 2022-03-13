
import 'dart:async';

import 'package:eco_slide_puzzle/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/data_repository.dart';
import '../../models/leaderBoardData.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
  return const MaterialApp(
  title: _title,
  home: MyStatefulWidget(),
  );
  }
  }

  class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
  }

  class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  /*
  final Future<String> _calculation = Future<String>.delayed(
  const Duration(seconds: 2),
  () => 'Data Loaded',
  );
*/
    DataRepository datastore = DataRepository();

  @override
  Widget build(BuildContext context) {
  return DefaultTextStyle(

  style: Theme.of(context).textTheme.headline2!,
  textAlign: TextAlign.center,
  child: FutureBuilder<dynamic>(
  future: datastore.getLeaderBoard(), // a previously-obtained Future<String> or null
  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  List<Widget> children;
  if (snapshot.hasData) {
  children = <Widget>[
  const Icon(
  Icons.check_circle_outline,
  color: Colors.green,
  size: 60,
  ),
  Padding(
  padding: const EdgeInsets.only(top: 16),
  child: Text('Result: ${snapshot.data}'),
  )
  ];
  } else if (snapshot.hasError) {
  children = <Widget>[
  const Icon(
  Icons.error_outline,
  color: Colors.red,
  size: 60,
  ),
  Padding(
  padding: const EdgeInsets.only(top: 16),
  child: Text('Error: ${snapshot.error}'),
  )
  ];
  } else {
  children = const <Widget>[
  SizedBox(
  width: 60,
  height: 60,
  child: CircularProgressIndicator(),
  ),
  Padding(
  padding: EdgeInsets.only(top: 16),
  child: Text('Under development, coming soon ...'),
  )
  ];
  }
  return Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: children,
  ),
  );
  },
  ),
  );
  }


}