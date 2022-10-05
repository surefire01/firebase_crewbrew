import 'package:flutter/material.dart';

import '../../Shared/loading.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
                Text("Create your account", style: Theme.of(context).textTheme.headlineMedium,),
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
                        setState(() => loading=true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result==null){
                          setState(() {
                            error= "please supply valid email";
                            loading =false;
                          }
                          );
                        }
                      }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),
                    child: const Text("Register", style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account already?  "),
                    GestureDetector(
                      child:const Text("Login In",style: TextStyle(color: Colors.blue),),
                      onTap: (){widget.toggleView();},
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(error, style: const TextStyle(color: Colors.red),),
              ],
            ),
          )
      ),
    );
  }
}
