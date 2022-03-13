


import 'dart:collection';


import 'package:eco_slide_puzzle/models/ScoreBoard.dart';

import 'package:eco_slide_puzzle/models/player.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../models/tile.dart';




class DataRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref("players/");

  addPlayer(String uid, Player player) async {
   // print(" Adding a player " + player.toJson().toString());

    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "players/" + uid + "/profile/");

   await ref.set(player.toJson());
        /*.then((value) =>
        print("user added")).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.}
    }
    );
    */

    return;
  }

  Future<void> updatePlayer(String uid, Player player) async {
    FirebaseDatabase.instance.setLoggingEnabled(true);
    //ref.child(player.uid );
   // print("Going to update " + player.toJson().toString());
   // String uid = player.uid;
    try {
      var res = await ref.child(uid + "/profile/")
          .update(player.toJson());

         // .whenComplete(() => print("user updated"));
      return res;
    }

    on Exception {
      rethrow;
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
      if (kDebugMode) {
        print (" value " + value.toString());
      }
      return Player.fromJson(value);
    });
  }

  updateTiles(String uid, int size, List<Tile> tiles) async {
    //print("Going to update " + uid);
    try {

      Map<String, Object?> tempMap = HashMap();
      tiles.forEach((element) {


        tempMap.putIfAbsent(element.value.toString(), () => element.toJson());


      });

      await ref.child(uid + "/" + size.toString() + "/tile/" ).update(
          tempMap);
          /*.
      whenComplete(() => print("Tile updated"));
      */
      return;
    }
    on Exception {
      //print("_________________________________");

      rethrow;
    }
  }

  getTiles(String uid, int size, List<Tile> tiles) async {
   // print("Going to get Tile for  " + uid);

    await ref.child(uid + "/" + size.toString() + "/tile/").once().then((result) {
      var res = result.snapshot.value;
     // print (res.toString());
      if (res == null) {
        return null;
      }
      List value = result.snapshot.value as List<dynamic>;
      tiles.clear();

        value.forEach((element) {
            if (element != null) {
              tiles.add(Tile.fromJson(element as Map));
            }

        });
      tiles.forEach((element) { if (kDebugMode) {
        print(" INSIDE GET TILES " + element.toJson().toString());
      } });

    });
  }

  updateScoreBoard(String uid, ScoreBoard scoreBoard) async {
   // print("Going to update score board" + uid);
    try {
        await ref.child(uid + "/" + scoreBoard.size.toString() + "/score/" ).update(
            scoreBoard.toJson());
       // whenComplete(() => print("Score updated"));

      return;
    }
    on Exception catch (error) {
     // print("_________________________________");
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<bool> getScoreBoard(String uid, ScoreBoard sb) async {
    //print("Going to get score board " + uid);
    bool isUpdated = false;

    DatabaseReference starCountRef =
    ref.child(uid + "/" + sb.size.toString() + "/score/");

    await starCountRef.onValue.listen((DatabaseEvent event) {

      var sbTemp = ScoreBoard.fromJson(event.snapshot.value as Map<String, dynamic>);
      sb.copyWith(sbTemp);

      isUpdated = true;
    });
    return isUpdated;
  }

  getStartupScoreBoard(String uid, ScoreBoard sb) async {
   // print("Going to get score board " + uid);

    await ref.child((uid + "/" + sb.size.toString() + "/score/")).once().then((result) {
      var res = result.snapshot.value;
      if (res == null) {
        return null;
      }
      Map<String, dynamic> value = result.snapshot.value as Map<String,
          dynamic>;
      var sbTemp = ScoreBoard.fromJson(value);
      sb.copyWith(sbTemp);


      if (kDebugMode) {
        print (" Score board GOT " + value.toString());
      }

      if (kDebugMode) {
        print (" Score board GOT from Json " + sb.toJson().toString());
      }
      return sb;
    });

  }

  getLeaderBoard() async {

    if (kDebugMode) {
      print (" got DB reference " + ref.get().toString());
    }
   // ref = ref.child("profile");
    return await ref.once().then((result) {
      var res = result.snapshot.value as Iterable;

      if (null == res) {
        if (kDebugMode) {
          print ("result is empty");
        }
        return null;
      }
      if (kDebugMode) {
        print (" res is " + res.toString());
      }
      // Map<String, dynamic> value = result.snapshot.value as Map<String,
      //dynamic>;

      // print (" Score board GOT " + value.toString());
      for(var item in res) {
        if (kDebugMode) {
          print(item);
        }
      }
      //print(" value GOT from Json " + result.snapshot.value.toString());
      var sb = result.snapshot.value as Future<dynamic>;
      return sb;
    });
  }
  getLeaderBoardQuery() {
    return ref;
  }
  }