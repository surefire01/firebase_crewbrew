import 'package:firebase_crewbrew/Shared/loading.dart';
import 'package:firebase_crewbrew/models/user.dart';
import 'package:firebase_crewbrew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String? _currentName ;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID?>(context);

    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Update your brew setting",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: const InputDecoration(
                      hintText: "Enter your Name",
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "PLease enter your name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // drop down
                  DropdownButtonFormField(
                    value: _currentSugar ?? userData!.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugar"),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugar = val.toString()),
                  ),
                  //slider for strength
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    activeColor:
                        Colors.brown[(_currentStrength ?? userData?.strength)!],
                    inactiveColor:
                        Colors.brown[(_currentStrength ?? userData?.strength)!],
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                    divisions: 8,
                    onChanged: (val) {
                      setState(() => _currentStrength = val.toInt());
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserdata(
                            _currentSugar ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Update"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                      ))
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
