import 'package:eco_slide_puzzle/models/ScoreBoard.dart';
import 'package:eco_slide_puzzle/models/player.dart';

Players _PlayersFromJson(Map<dynamic, dynamic> json) {
  return Players (
      player: json ['player'],
      scoreBoard: json ['scoreBoard']
  );
}

class Players {
  final Player? player;
  final Map<int, ScoreBoard>? scoreBoard;

  Players(
      {required this.player, required this.scoreBoard}
  );
  factory Players.fromJson(Map<String, dynamic> json) => _PlayersFromJson(json);
}

