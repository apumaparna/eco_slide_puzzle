

//
Player _PlayerFromJson(Map<dynamic, dynamic> json) {
  return Player(
    email: json['email'],
    displayName: json['displayName'],
    //uid: json['uid'],
    dateCreated: DateTime.parse(json['dateCreated'])

   // scoreBoard: _ScoreBoardFromJson(json['scoreBoard']),
  );
}

//
Map<String, dynamic> _PlayerToJson(Player instance) => <String, dynamic>{
  'email': instance.email,
  'displayName': instance.displayName,
  //'uid': instance.uid,
  'dateCreated': instance.dateCreated.toIso8601String(),
 // 'scoreBoard': _ScoreBoardToJson(instance.scoreBoard),
};

class Player {
  final String email;
 final String? displayName;
 // final String uid;
  final DateTime dateCreated;
 // ScoreBoard scoreBoard;


  Player(
      {required this.email,
        required this.displayName,
    //    required this.uid,
        required this.dateCreated
      // required this.scoreBoard
      });

  factory Player.fromJson(Map<String, dynamic> json) => _PlayerFromJson(json);

  // 5
  Map<String, dynamic> toJson() => _PlayerToJson(this);
  @override
  String toString() => "Player<$email>";

}