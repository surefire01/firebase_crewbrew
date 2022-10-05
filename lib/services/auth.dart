import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crewbrew/models/user.dart';
import 'package:firebase_crewbrew/services/database.dart';



class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserUID? _userUIDfromUser (User? user){
    return user==null ? null : UserUID(uid: user.uid);
  }


  Stream<UserUID?> get user{
    return _auth.authStateChanges().map(_userUIDfromUser);
  }

  
  //sign in with anonymous
  Future signInAnon() async{
    try{

      UserCredential userCredential = await _auth.signInAnonymously();

      User? user = userCredential.user;

      return _userUIDfromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }


  // sigm with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userUIDfromUser(result.user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //create a new document for the user using uid

      await DatabaseService(uid: result.user!.uid).updateUserdata("0", "New Crew Member",100);

      return _userUIDfromUser(result.user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}