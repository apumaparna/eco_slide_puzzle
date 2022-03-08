class ScoreBoard {
   int score=0;
   int numberOfMoves=0;
   int timeTaken=0;
  DateTime datePlayed;
  int size;

  ScoreBoard(
      {required this.score,
        required this.numberOfMoves,
        required this.timeTaken,
        required this.datePlayed,
      required this.size});

  factory ScoreBoard.fromJson(Map<dynamic?, dynamic?> json) =>
      _ScoreBoardFromJson(json);

  Map<String, dynamic> toJson() => _ScoreBoardToJson(this);
/*
  int get highScore {
    return this.score;
  }

 */
}

ScoreBoard _ScoreBoardFromJson(Map<dynamic, dynamic> json) {
  return ScoreBoard(
      score: json['score'],
      numberOfMoves: json['numberOfMoves'],
      datePlayed: DateTime.parse(json['datePlayed']),
      timeTaken: json['timeTaken'],
      size :json['size']);
}

Map<String, dynamic> _ScoreBoardToJson(ScoreBoard instance) =>
    <String, dynamic>{
      'score': instance.score,
      'numberOfMoves': instance.numberOfMoves,
      'datePlayed': instance.datePlayed.toIso8601String(),
      'timeTaken': instance.timeTaken,
      'size' : instance.size
    };
