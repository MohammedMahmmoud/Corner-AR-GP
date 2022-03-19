import 'package:corner_ar_gp/database/DatabaseHelper.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Person{
  late String name, email, id;

  Person({String name = '', String email = '', String id = ''}){
    this.name = name;
    this.email = email;
    this.id = id;
  }

  void setFirstName(String fName){
    name = fName;
  }
  void setLastName(String lName){
    name += ' ' + lName;
  }
  void setEmail(String email){
    email = email;
  }

  Future<bool> registration(GlobalKey<FormState> formKey, String password, bool isAdmin) async {
    if(formKey.currentState?.validate() == true){
      final personRef = isAdmin? getAdminsCollectionWithConverter() : getUsersCollectionWithConverter();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        id = userCredential.additionalUserInfo?.providerId as String;
        print(id);
        
        personRef.add(
          Person(
            id: id,
            name: name,
            email: email
          )
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

  Future<bool> logIn( String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
}