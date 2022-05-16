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
    // if (firebaseCurrentUser != null) {
    //   String _collectionName = app_user.User.CollectionName;
    //   _checkAdmin(firebaseCurrentUser.uid).then((value) => _collectionName = Admin.CollectionName);
    //   print(_collectionName);
    //   _fetchUsers(_collectionName, firebaseCurrentUser).then((value) => loggedUser = value);
    //   //print(loggedUser!.email+'+++++++++++++++++++++++'+loggedUser!.id+'++++++++++++++++'+loggedUser!.name);
    // }
    return firebaseCurrentUser != null;
  }

  Future<void> fetchLoggedUser() async {
    final firebaseCurrentUser = FirebaseAuth.instance.currentUser;
    if (firebaseCurrentUser != null) {
      String _collectionName = app_user.User.CollectionName;
      _checkAdmin(firebaseCurrentUser.uid).then((value) => _collectionName = Admin.CollectionName);
      print(_collectionName);
      await _fetchUsers(_collectionName, firebaseCurrentUser).then((value) => loggedUser = value);
      //print(loggedUser!.email+'+++++++++++++++++++++++'+loggedUser!.id+'++++++++++++++++'+loggedUser!.name);
    }
  }

  Future<Person> _fetchUsers(String collectionName, firebaseCurrentUser) async {
    Person collectionPerson = Person();
     await getPersonCollectionWithConverter(collectionName)
        .doc(firebaseCurrentUser.uid)
        .get()
        .then((user) {
          if (user.data() != null) {
            collectionPerson =  app_user.User();
            _checkAdmin(firebaseCurrentUser.uid).then((value) => collectionPerson = Admin());
            collectionPerson = user.data()!;
            //notifyListeners();
            //print(collectioPerson!.email+'----------'+collectioPerson!.id+'------------------'+collectioPerson!.name);
          }
        });
      //print(loggedUser!.email+'+++++++++++++++++++++++'+loggedUser!.id+'++++++++++++++++'+loggedUser!.name);

    //notifyListeners();
    return collectionPerson;
    // await Future.delayed(const Duration(milliseconds: 100), (){
    //   notifyListeners();
    // });

  }

  void updateLoggedUser(Person user) {
    print("from ap provider update");
    loggedUser = user;
    print('-----------------------to be notified---------------------');
    notifyListeners();
    print('-----------------------to be notified---------------------');
  }

  Person getLoggedUser(){
    //print(loggedUser!.email+'00000000000000000000'+loggedUser!.id+'0000000000000000000000000'+loggedUser!.name);
    return loggedUser ?? Person();
  }

  Future<bool> _checkAdmin(String id)  async{
    final adminReference = await getPersonCollectionWithConverter(Admin.CollectionName).doc(id).get();
    FirebaseFirestore.instance
        .collection(Admin.CollectionName)
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
          print("checccccccccccccccccccccccccccccckijng  ${value.size}");
      },
    );
    return adminReference.exists;
  }
}
