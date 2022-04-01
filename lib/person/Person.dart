import 'package:corner_ar_gp/components/getdata_components.dart';
import 'package:corner_ar_gp/database/DatabaseHelper.dart';
import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/user_homescreen.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/User.dart' as app_user;
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/login/LoginPage.dart';
import '../main_screens/list_page/ListPage.dart';

class Person{
  late String name, email, id, lstName;
  var _errorMsg = null;

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
  void setPerson(Person person)
  {
    this.email = person.email;
    this.name = person.email;
    this.id = person.id;
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

  Future<bool> registration(GlobalKey<FormState> formKey, String password, bool isAdmin, BuildContext context) async {
    if(formKey.currentState?.validate() == true){
      final personRef = getPersonCollectionWithConverter(isAdmin? Admin.CollectionName :
                          app_user.User.CollectionName);
      name = name + ' ' + lstName;
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        final AppProvider _myAppProvider =  Provider.of<AppProvider>(context, listen: false);
        id = userCredential.user!.uid;

        personRef.doc(id).set(
            Person(
              name: name,
              email: email,
              id: id
            )
        ).then((user)async{
          _myAppProvider.updateLoggedUser(this);
          var data = await getData(Admin.CollectionName);
          Navigator.pushReplacement<void, void>(
            context,
            isAdmin?MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ListPage(
                    title: "Add Admin",
                    collectionName: Admin.CollectionName,
                    Data: data,
                    dataLength: data.length,
                  ),
            ):MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  UserHomeScreen(),
            ),
          );
        });
        print('done --------------------------------------------------------------');
        return true;
      } on FirebaseAuthException catch (e) {
        _errorMsg = e;
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
          final AppProvider _myAppProvider =  Provider.of<AppProvider>(context, listen: false);
          //final db = FirebaseFirestore.instance;
          final adminRefrence =
            await getPersonCollectionWithConverter(Admin.CollectionName).doc(userCredential.user!.uid).get();

          final userRef = await getPersonCollectionWithConverter(adminRefrence.exists? Admin.CollectionName :
          app_user.User.CollectionName)
              .doc(userCredential.user!.uid)
              .get()
              .then((retrievedUser) async{
                email = await retrievedUser.data()!.email;
                id = await retrievedUser.data()!.id;
                name = await retrievedUser.data()!.name;

                _myAppProvider.updateLoggedUser(this);

                Navigator.pushReplacement<void, void>(
                  context,
                  adminRefrence.exists?MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AdminHomeScreen(),
                  ):MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        UserHomeScreen(),
                  ),
                );
              });
        }
        print("loooooged222222222222");
      } on FirebaseAuthException catch (e) {
        _errorMsg = e;
        formKey.currentState?.validate();
      } catch (e) {
        print(e);
        print("errrrrrrrrrrrrrrrrrrorr");
      }
    }
    return false;
  }

  Future<void> logOut(context) async{
    print("logggggoutttttttttttperson");
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, Login.routeName);
  }

  Future<void> updateName(GlobalKey<FormState> formKey) async {
    if(formKey.currentState?.validate() == true) {
      print('uupddaattiinngg nnaammee');
      name += ' ' + lstName;
      print(name + ' ______________________________________');
      print('-------------------------------' + id);

      final adminReference = await getPersonCollectionWithConverter(
          Admin.CollectionName).doc(id).get();
      final userRef = await getPersonCollectionWithConverter(
          adminReference.exists ? Admin.CollectionName :
          app_user.User.CollectionName);

      userRef.doc(id)
          .update({'name': name})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  Future<void> updateEmail(GlobalKey<FormState> formKey, String newEmail, String currentPassword) async {
    if(formKey.currentState?.validate() == true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: currentPassword
        );
      } on FirebaseAuthException catch (e) {
        _errorMsg = e;
        formKey.currentState?.validate();
      }
      print('uupddaattiinngg emaillllllllll');
      print('-------------------------------' + id);

      final adminReference = await getPersonCollectionWithConverter(
          Admin.CollectionName).doc(id).get();
      final userRef = getPersonCollectionWithConverter(
          adminReference.exists ? Admin.CollectionName :
          app_user.User.CollectionName);

      userRef.doc(id)
          .update({'email': email})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));

      final firebaseCurrentUser = FirebaseAuth.instance.currentUser;
      firebaseCurrentUser?.updateEmail(newEmail);
      AuthCredential credential = EmailAuthProvider.credential(email: newEmail, password: currentPassword);
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
    }
  }

  Future<void> updatePassword(GlobalKey<FormState> formKey, String currentPassword, String newerPassword) async {
    if (formKey.currentState?.validate() == true) {
      print('hello');
      print(currentPassword);
      print(newerPassword);
      try {
        // UserCredential userCredential = await FirebaseAuth.instance
        //     .signInWithEmailAndPassword(
        //     email: email,
        //     password: currentPassword
        // );
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
        print('passordCorrect');
      } on FirebaseAuthException catch (e) {
        _errorMsg = e;
        formKey.currentState?.validate();
        print('current password not correct');
        print(e.message);
      }
      var user = FirebaseAuth.instance.currentUser;

      //Pass in the password to updatePassword.
      user?.updatePassword(newerPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }
  }

  Future<void> deleteAccount() async{
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  String? mailValidator([String? value])
  {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }else if(_errorMsg != null) {
      if(_errorMsg.code != 'weak-password' && _errorMsg.code != 'wrong-password') {
        if(_errorMsg.code == 'user-not-found') {
          _errorMsg = null;
          return 'No user found for that email.';
        }else {
          String msg = _errorMsg.message;
          _errorMsg = null;
          return msg;
        }
      }
    }
    return null;
  }

  String? passwordValidator([String? value]){
    if(value == null || value.isEmpty){
      return 'Please enter a password';
    }else if(_errorMsg != null){
      if(_errorMsg.code == 'weak-password' || _errorMsg.code == 'wrong-password') {
        if(_errorMsg.code == 'wrong-password'){
          _errorMsg = null;
          return 'The password provided for this account is wrong';
        }else {
          String msg = _errorMsg.message;
          _errorMsg = null;
          return msg;
        }
      }
    }
    return null;
  }

}




