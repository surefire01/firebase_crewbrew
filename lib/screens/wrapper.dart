
import 'package:firebase_crewbrew/models/user.dart';
import 'package:firebase_crewbrew/screens/Home/home.dart';
import 'package:firebase_crewbrew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crewbrew/models/user.dart';
import 'package:provider/provider.dart';

// this is not a page but this widgets checks if the useris logged in or not and based on that shows home scree or authentiate


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserUID?>(context);
    print(user?.uid);
    return user == null ? Authenticate() : Home();

  }
}
