import 'package:corner_ar_gp/main_screens/edit_info/edit_person_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/login/LoginPage.dart';
import '../person/Person.dart';


Drawer sideMenu(
{
  //required BuildContext context,
  required Function changeToEditPage,
  required String userName,
  required bool isAdmin,
  required BuildContext buildContext,
  required Person personObject
}
    ){
  return Drawer(
    backgroundColor: Color(0xFF71A2B5),
    child: ListView(
      children: [
        DrawerHeader(
          child: Text(
            userName,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
            //color: Color(0xFFbdc6cf),
          ),
        ),
        Container(child: ElevatedButton(
            onPressed: ()=> changeToEditPage(),//Navigator.pushNamed(context, EditPersonInformation.routeName),
            child: Text("Edit Profile"),
            style:ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Color(0xFF71A2B5),))
        ),
        //if user show saved furniture button
        isAdmin?Container(child:null):
        Container(child: ElevatedButton(onPressed: (){}, child: Text("Saved Furniture"),style:ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xFF71A2B5),))),

        Container(child: ElevatedButton(onPressed: (){

          personObject.logOut(buildContext);
        }//()=>logOut(buildContext)
            , child: Text("Log out"),style:ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xFF71A2B5),))),
      ],
    ),
  );
}