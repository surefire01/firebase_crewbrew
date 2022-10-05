import "package:flutter/material.dart";
import 'package:firebase_crewbrew/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({required this.brew});

  int co = 10;

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.only(top: 8,),
      child:Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            child: const Icon(Icons.circle_outlined, color: Colors.white,size: 50,),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar'),
        ),
      ) ,
    );
  }
}

