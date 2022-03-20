import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/database/DatabaseHelper.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/User.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen/user_homescreen.dart';

class Person{
  late String name, email, id, lstName;

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
      final personRef = isAdmin? getAdminsCollectionWithConverter() : getUsersCollectionWithConverter();
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
        return true;
      } on FirebaseAuthException catch (e) {
        // errorFun()
      } catch (e) {
        // somethingWentWrong()
      }
    }
    return false;
  }

  Future<bool> logIn(String password, BuildContext context) async{
    print("loooooged11111");
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
      }else {
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
              builder: (BuildContext context) => UserHomeScreen(userCredential.user!.uid),
            ),
          );
          /*Navigator.pushReplacementNamed<void, void>(context,
              UserHomeScreen.routeName,
              ));*/
        });
      }
      print("loooooged222222222222");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e);
      print("errrrrrrrrrrrrrrrrrrorr2222222222");
    }catch(e){
      print(e);
      print("errrrrrrrrrrrrrrrrrrorr");
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

  String? validator([String? value])
  {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    return null;
  }

}

// if (e.code == 'weak-password') {
// print('The password provided is too weak.');
// } else if (e.code == 'email-already-in-use') {
// print('The account already exists for that email.');
// }
// print(e);


