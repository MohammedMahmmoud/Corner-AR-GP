import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<bool> registration(GlobalKey<FormState> formKey, String password, bool isAdmin,String email) async {
    if(formKey.currentState?.validate() == true){
      final personRef = isAdmin? getAdminsCollectionWithConverter() : getUsersCollectionWithConverter();
      try {
        print("heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        print(email);
        print(password);
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        print("heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222222222");
        id = userCredential.user!.uid;
        //id = userCredential.additionalUserInfo?.providerId as String;
        print(id);

        /*User myuser = Person(
            id: id,
            name: name,
            email: email)as User;

        Person per = myuser as Person;

        personRef.add(per);*/

        /*final per = Person(
            id: id,
            name: name,
            email: email
        );
        personRef.add(per);*/
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
        print(e);
        print("errrrrrrrrrrrrrrrrrrorr2222222222");
      } catch (e) {
        print(e);
        print("errrrrrrrrrrrrrrrrrrorr");
      }
    }
    return false;
  }

  Future<bool> logIn(String password, String email) async{
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
          print(retrievedUser.data());
          //provider.updateUser(retrievedUser.data());
          //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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

}