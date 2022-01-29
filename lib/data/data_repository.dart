
import 'package:eco_slide_puzzle/models/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';



class DataRepository {

//final String path = "https://eco-slide-puzzle-default-rtdb.firebaseio.com/";
 // DatabaseReference ref = FirebaseDatabase.instance.ref("players");
 // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final databaseReference = FirebaseDatabase.instance.ref();

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('players');


  Future<void> addPlayer(Player player) async {
    print (" Adding a player " + player.toJson().toString());
    DatabaseReference ref = FirebaseDatabase.instance.ref("players/" + player.uid );
    await ref.set(player.toJson());
    return ;
  }

  updatePlayer(Player player) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("players/" + player.uid );
    await ref.set(player.toJson());
   // await collection.doc(player.uid).update(player.toJson());
  }

  Future<Player?> getPlayer(String uid) async {
    //var query = collection.where("uid", isEqualTo: uid);
    DatabaseReference ref = FirebaseDatabase.instance.ref("players/" + uid );
    if (ref == null){
      print("DatabaseReference is null");

      return null;
    }

    return await ref
        .once()
        .then((result) {
      Map<String,dynamic> value = result.snapshot.value as Map<String, dynamic>;
      return Player.fromJson(value);
    });

  }
}