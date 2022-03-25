import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/database/DatabaseHelper.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/person/User.dart' as app_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
   Person? loggedUser;

  bool checkLoggedUser(){
    //FirebaseAuth.instance.signOut();
    final firebaseCurrentUser = FirebaseAuth.instance.currentUser;
    if (firebaseCurrentUser != null) {
      String _collectionName = _checkAdmin(firebaseCurrentUser.uid)? Admin.CollectionName : app_user.User.CollectionName;
      //_checkAdmin(firebaseCurrentUser.uid).then((value) => _collectionName = Admin.CollectionName);
      print(_collectionName);
      _fetchUsers(_collectionName, firebaseCurrentUser);
    }
    return firebaseCurrentUser != null;
  }

  Future<void> _fetchUsers(String collectionName, firebaseCurrentUser) async{
    await getPersonCollectionWithConverter(collectionName)
        .doc(firebaseCurrentUser.uid)
        .get()
        .then((user) {
          if (user.data() != null) {
            loggedUser = _checkAdmin(firebaseCurrentUser.uid) ? Admin() : app_user.User();
            //_checkAdmin(firebaseCurrentUser.uid).then((value) => loggedUser = Admin());
            loggedUser = user.data()!;
          }
        });
     //notifyListeners();
  }

  void updateLoggedUser(Person user) {
    loggedUser = user;
    notifyListeners();
  }

  Person getLoggedUser(){
    return loggedUser ?? Person();
  }

  bool _checkAdmin(String id)  {
    FirebaseFirestore.instance
        .collection(Admin.CollectionName)
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
            return value.size != 0;
      },
    );

    return false;
  }
}
