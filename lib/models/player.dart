
import 'package:flutter/material.dart';

//1
Player _PlayerFromJson(Map<dynamic, dynamic> json) {
  return Player(
    email: json['email'],
    //uid: json['uid'],
    dateCreated: DateTime.parse(json['dateCreated'])

   // scoreBoard: _ScoreBoardFromJson(json['scoreBoard']),
  );
}

//2
Map<String, dynamic> _PlayerToJson(Player instance) => <String, dynamic>{
  'email': instance.email,
  //'uid': instance.uid,
  'dateCreated': instance.dateCreated.toIso8601String(),
 // 'scoreBoard': _ScoreBoardToJson(instance.scoreBoard),
};

class Player {
  final String email;
 // final String uid;
  final DateTime dateCreated;
 // ScoreBoard scoreBoard;


  Player(
      {required this.email,
    //    required this.uid,
        required this.dateCreated
      // required this.scoreBoard
      });

  factory Player.fromJson(Map<String, dynamic> json) => _PlayerFromJson(json);

  // 5
  Map<String, dynamic> toJson() => _PlayerToJson(this);
  @override
  String toString() => "Player<$email>";
/*
  ScoreBoard get player_scoreBoard {
    return this.scoreBoard;
  }
  */

}