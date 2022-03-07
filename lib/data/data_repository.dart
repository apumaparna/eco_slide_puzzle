


import 'dart:collection';
import 'dart:io';

import 'package:eco_slide_puzzle/models/ScoreBoard.dart';
import 'package:eco_slide_puzzle/models/player.dart';

import 'package:firebase_database/firebase_database.dart';

import '../models/tile.dart';




class DataRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref("players/");

  addPlayer(String uid, Player player) async {
   // print(" Adding a player " + player.toJson().toString());

    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "players/" + uid + "/profile/");

    var res = await ref.set(player.toJson()).then((value) =>
        print("user added")).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.

    });

    return;
  }

  Future<void> updatePlayer(String uid, Player player) async {
    FirebaseDatabase.instance.setLoggingEnabled(true);
    //ref.child(player.uid );
   // print("Going to update " + player.toJson().toString());
   // String uid = player.uid;
    try {
      var res = await ref.child(uid + "/profile/")
          .update(player.toJson())
          .whenComplete(() => print("user updated"));
      return res;
    }

    on Exception catch (error) {
      print("_________________________________");
      print(error);
    }
  }

  Future<Player?> getPlayer(String uid) async {
    //var query = collection.where("uid", isEqualTo: uid);
    //ref.child(uid );

    return await ref.child(uid+ "/profile/")
        .once()
        .then((result) {
      var res = result.snapshot.value;
      if (res == null) {
        return null;
      }
      Map<String, dynamic> value = result.snapshot.value as Map<String,
          dynamic>;

      return Player.fromJson(value);
    });
  }

  updateTiles(String uid, List<Tile> tiles) async {
    print("Going to update " + uid);
    try {
      var tileList = [];
      Map<String, Object?> tempMap = HashMap();
      tiles.forEach((element) {


        tempMap.putIfAbsent(element.value.toString(), () => element.toJson());
        //tileList.add(tempMap);

      });

      await ref.child(uid + "/tile/" ).update(
          tempMap).
      whenComplete(() => print("Tile updated"));
      /*
      tiles.forEach((element) async {
        //print(" Tile " + element.toJson().toString());

        await ref.child(uid + "/tile/" + element.value.toString() + "/").update(
            element.toJson()).
        whenComplete(() => print("Tile updated"));
      });
      */

      return;
    }
    on Exception catch (error) {
      print("_________________________________");
      print(error);
    }
  }

  getTiles(String uid, List<Tile> tiles) async {
   // print("Going to get Tile for  " + uid);

    await ref.child(uid + "/tile/").once().then((result) {
      var res = result.snapshot.value;
      print (res.toString());
      if (res == null) {
        return null;
      }
      List value = result.snapshot.value as List<dynamic>;

        tiles.forEach((element ) {
          tiles.remove(element as Map);
        });
        value.forEach((element) {
            if (element != null) {
              tiles.add(Tile.fromJson(element as Map));
            }

        });
      tiles.forEach((element) { print(" INSIDE GET TILES " + element.toJson().toString()); });

    });
  }

  updateScoreBoard(String uid, ScoreBoard scoreBoard) async {
   // print("Going to update score board" + uid);
    try {
        await ref.child(uid + "/score/" ).update(
            scoreBoard.toJson()).
        whenComplete(() => print("Score updated"));

      return;
    }
    on Exception catch (error) {
      print("_________________________________");
      print(error);
    }
  }

  Future<bool> getScoreBoard(String uid, ScoreBoard sb) async {
    //print("Going to get score board " + uid);
    bool isUpdated = false;

    DatabaseReference starCountRef =
    ref.child(uid + "/score/");

    await starCountRef.onValue.listen((DatabaseEvent event) {

      var sbTemp = ScoreBoard.fromJson(event.snapshot.value as Map<String, dynamic>);
      sb.numberOfMoves = sbTemp.numberOfMoves;
      sb.datePlayed = sbTemp.datePlayed;
      sb.timeTaken = sbTemp.timeTaken;
      sb.score = sbTemp.score;
      print(" Score Saved is " + sb.toString());
      isUpdated = true;
    });
    return isUpdated;
  }

  getStartupScoreBoard(String uid, ScoreBoard sb) async {
   // print("Going to get score board " + uid);

    await ref.child(uid + "/score/").once().then((result) {
      var res = result.snapshot.value;
      if (res == null) {
        return null;
      }
      Map<String, dynamic> value = result.snapshot.value as Map<String,
          dynamic>;
      var sbTemp = ScoreBoard.fromJson(value);
      sb.numberOfMoves = sbTemp.numberOfMoves;
      sb.datePlayed = sbTemp.datePlayed;
      sb.timeTaken = sbTemp.timeTaken;
      sb.score = sbTemp.score;
     // print (" Score board GOT " + value.toString());

      print (" Score board GOT from Json " + sb.toJson().toString());
      return sb;
    });

  }
}