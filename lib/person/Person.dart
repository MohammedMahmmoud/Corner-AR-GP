import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/database/DatabaseHelper.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/User.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen/user_homescreen.dart';

class Person{
  late String name, email, id, lstName;
  var errorMsg = null;


  Person({String name = '', String email = '', String id = ''}){
    this.name = name;
    this.email = email;
    this.id = id;
  }


  void setFirstName(String fName){
    this.name = fName;
  }
  void setLastName(String lName){
    lstName = lName;
  }
  void setEmail(String email){
    this.email = email;
  }

  Person.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    email: json['email']! as String,
  );

  //to write in db
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'email' : email,
    };
  }

  Future<bool> registration(GlobalKey<FormState> formKey, String password, bool isAdmin) async {
    if(formKey.currentState?.validate() == true){
      final personRef_2 = getPersonCollectionWithConverter(isAdmin? Admin.CollectionName :
                          user.User.CollectionName);
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        id = userCredential.user!.uid;

        personRef_2.add(
            Person(
              name: name + ' ' + lstName,
              email: email,
              id: id
            )
        );
        print('done --------------------------------------------------------------');
        return true;
      } on FirebaseAuthException catch (e) {
        errorMsg = e;
        formKey.currentState?.validate();
      } catch (e) {
        // somethingWentWrong()
      }
    }
    return false;
  }

  Future<bool> logIn(GlobalKey<FormState> formKey, String password, BuildContext context) async{
    if(formKey.currentState?.validate() == true) {
      try {
        print("loooooged222222222222333333333");
        print(email);
        print(password);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email,
            password: password
        );
        if (userCredential.user == null) {
          print("invalid creditional no user exist with this email");
        } else {
          final db = FirebaseFirestore.instance;
          final userRef = getUsersCollectionWithConverter()
              .doc(userCredential.user!.uid)
              .get()
              .then((retrievedUser) {
            /*print(retrievedUser.data()!.email);
          print(retrievedUser.data()!.id);
          print(retrievedUser.data()!.name);*/
            //provider.updateUser(retrievedUser.data());
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    UserHomeScreen(userCredential.user!.uid),
              ),
            );
            /*Navigator.pushReplacementNamed<void, void>(context,
              UserHomeScreen.routeName,
              ));*/
          });
        }
        print("loooooged222222222222");
      } on FirebaseAuthException catch (e) {
        errorMsg = e;
        formKey.currentState?.validate();
      } catch (e) {
        print(e);
        print("errrrrrrrrrrrrrrrrrrorr");
      }
    }
    return false;
  }

  /*void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }*/

  String? mailValidator([String? value])
  {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }else if(errorMsg != null) {
      if(errorMsg.code != 'weak-password' && errorMsg.code != 'wrong-password') {
        if(errorMsg.code == 'user-not-found') {
          errorMsg = null;
          return 'No user found for that email.';
        }else {
          String msg = errorMsg.message;
          errorMsg = null;
          return msg;
        }
      }
    }
    return null;
  }

  String? passwordValidator([String? value]){
    if(value == null || value.isEmpty){
      return 'Please enter a password';
    }else if(errorMsg != null){
      if(errorMsg.code == 'weak-password' || errorMsg.code == 'wrong-password') {
        if(errorMsg.code == 'wrong-password'){
          errorMsg = null;
          return 'The password provided for this account is wrong';
        }else {
          String msg = errorMsg.message;
          errorMsg = null;
          return msg;
        }
      }
    }
    return null;
  }

}




