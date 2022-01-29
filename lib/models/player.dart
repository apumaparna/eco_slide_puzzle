
import 'package:flutter/material.dart';


class ScoreBoard {
  final int score;
  final int numberOfMoves;
  final int timeTaken;
  final DateTime datePlayed;

  ScoreBoard(
      {required this.score,
        required this.numberOfMoves,
        required this.timeTaken,
        required this.datePlayed});

  factory ScoreBoard.fromJson(Map<dynamic, dynamic> json) =>
      _ScoreBoardFromJson(json);

  Map<String, dynamic> toJson() => _ScoreBoardToJson(this);

  int get highScore {
    return this.score;
  }
}

ScoreBoard _ScoreBoardFromJson(Map<dynamic, dynamic> json) {
  return ScoreBoard(
      score: json['score'],
      numberOfMoves: json['numberOfMoves'],
      datePlayed: DateTime.parse(json['datePlayed']),
      timeTaken: json['timeTaken']);
}

Map<String, dynamic> _ScoreBoardToJson(ScoreBoard instance) =>
    <String, dynamic>{
      'score': instance.score,
      'numberOfMoves': instance.numberOfMoves,
      'datePlayed': instance.datePlayed.toIso8601String(),
      'timeTaken': instance.timeTaken,
    };

//1
Player _PlayerFromJson(Map<dynamic, dynamic> json) {
  return Player(
    email: json['email'],
    uid: json['uid'],
    dateCreated: DateTime.parse(json['dateCreated']),

    scoreBoard: _ScoreBoardFromJson(json['scoreBoard']),
  );
}

//2
Map<String, dynamic> _PlayerToJson(Player instance) => <String, dynamic>{
  'email': instance.email,
  'uid': instance.uid,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'scoreBoard': _ScoreBoardToJson(instance.scoreBoard),
};

class Player with ChangeNotifier {
  final String email;
  final String uid;
  final DateTime dateCreated;
  ScoreBoard scoreBoard;

  Player(
      {required this.email,
        required this.uid,
        required this.dateCreated,
        required this.scoreBoard});

  factory Player.fromJson(Map<String, dynamic> json) => _PlayerFromJson(json);

  // 5
  Map<String, dynamic> toJson() => _PlayerToJson(this);
  @override
  String toString() => "Player<$email>";

  ScoreBoard get player_scoreBoard {
    return this.scoreBoard;
  }
}