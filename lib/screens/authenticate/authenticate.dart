import 'package:firebase_crewbrew/screens/authenticate/register.dart';
import 'package:firebase_crewbrew/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';


// This page authenticates the user i.e. this is the Sigin or Signup page


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {


  bool showSignIn = false;

  void toggleView(){

    setState(() => showSignIn = !showSignIn);

  }


  @override
  Widget build(BuildContext context) {



    return showSignIn? SignIn(toggleView: toggleView,) : Register(toggleView:toggleView ,);
  }
}
