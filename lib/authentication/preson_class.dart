import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Person{
  late String _firstName, _lastName, _email;

  void setFirstName(String fName){
    _firstName = fName;
  }
  void setLastName(String lName){
    _lastName = lName;
  }
  void setEmail(String email){
    _email = email;
  }

  Future<bool> registration(GlobalKey<FormState> formKey, String password) async {
    if(formKey.currentState?.validate() == true){
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    return false;
  }
}