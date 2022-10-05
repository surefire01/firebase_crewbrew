import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crewbrew/models/user.dart';

import '../models/brew.dart';

class DatabaseService{

  final String uid;

  DatabaseService({required this.uid});


  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserdata(String sugars, String name, int strength)async{
    return brewCollection.doc(uid).set({
      "name" : name,
      "sugars" : sugars,
      "strength" : strength
    });
  }


  // brew list from Snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      var lis = doc.data() as Map;
      return Brew(name: lis["name"] ?? "", sugars: lis["sugars"] ?? "0", strength: lis["strength"] ?? 0);
    }).toList();
  }

  // create a stream for the change in the database
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot ){
    var lis = snapshot.data() as Map;
    return UserData(sugars: lis['sugars'] , name: lis['name'], strength: lis['strength'], uid: uid);
  }

  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}