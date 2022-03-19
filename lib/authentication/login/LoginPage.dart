import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late bool isPasswordHidden = true;
  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void logIn() async{
    try{
      //UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);


    }catch(e){

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 170, 30, 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (newValue){
                        email=newValue;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: isPasswordHidden? true : false,
                      onChanged: (newValue){
                        password=newValue;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordHidden?
                          Icons.visibility_off_outlined:
                          Icons.visibility_outlined),
                          onPressed: (){
                            isPasswordHidden = !isPasswordHidden;
                            setState(() {});
                          },
                        ),

                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "please enter your password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(70,80,70,0),
                child: ElevatedButton(
                  onPressed: () {
                    if(_loginFormKey.currentState?.validate() == true){
                      logIn();
                    }
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 50, 15, 12),
                child: TextButton(
                  onPressed: () {  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      )
    );
  }
}
