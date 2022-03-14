import 'package:eco_slide_puzzle/models/Players.dart';
import 'package:eco_slide_puzzle/models/ScoreBoard.dart';

import 'Players.dart';

LeaderBoardData _LeaderBoardFromJson(Map<dynamic, dynamic> json) {
  return LeaderBoardData (
      players: json ['players']
  );
}
class LeaderBoardData {
  final List<Players>? players;

  LeaderBoardData({required this.players});

  factory LeaderBoardData.fromJson(Map<String, dynamic> json) => _LeaderBoardFromJson(json);
}