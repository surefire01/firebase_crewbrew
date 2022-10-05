import 'package:firebase_crewbrew/Shared/loading.dart';
import 'package:firebase_crewbrew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email = "";
  String password = "";
  String error = "";

  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading? const Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BrewCrew", style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: 30,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Email Id"
                ),
                validator: (val) => val!.isEmpty? "Enter an email" : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Password"
                ),
                validator: (val) => val!.length < 6 ? "Password should contain atleast 8 characters":null ,
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val);
                },
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()) {
                      setState(()=>loading=true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          error = "please supply valid email";
                          loading = false;
                        });
                      }
                    }
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),
                  child: const Text("Sign in", style:  TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?  "),
                  GestureDetector(
                    child: const Text("Sign up",style: TextStyle(color: Colors.blue),),
                    onTap: (){widget.toggleView();},
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
