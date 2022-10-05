import 'package:firebase_crewbrew/screens/Home/settings_form.dart';
import 'package:firebase_crewbrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crewbrew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crewbrew/screens/Home/brew_list.dart';

import '../../models/brew.dart';

// this is the home screen


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return  Container(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: const SettingsForm(),
        );
      });
    }



    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("BrewCrew"),
          backgroundColor: Colors.brown[700],
          elevation: 0,
          actions: [
            IconButton(onPressed: ()async{
              await _auth.signOut();
            }, icon: const Icon(Icons.logout_outlined),),
            IconButton(
              icon: const Icon(Icons.settings,color: Colors.white,),
              onPressed: () => showSettingsPanel(),
            )
          ],

        ),
        body: Container(decoration:  const BoxDecoration(
            image: DecorationImage(
             image:  AssetImage("assets/bg_brewcrew.jpg"),
                 fit: BoxFit.cover,

             )

        ),child:  const BrewList(),
        ),

      ),
    );
  }
}
