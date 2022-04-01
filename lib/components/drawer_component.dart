import 'package:corner_ar_gp/components/buttons_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/login/LoginPage.dart';
import '../person/Person.dart';


Drawer sideMenu(
{
  required String userName,
  required bool isAdmin,
  required BuildContext buildContext,
  required Person personObject
}
    ){
  return Drawer(
    backgroundColor: Color(0xFF73929F),
    child: ListView(
      children: [
        DrawerHeader(
          child: Row(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/profile.png',
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ),
        listMenuButtons(
            buttonName: 'Edit Profile',
            onPressedButton: (){}
        ),
        const SizedBox(height: 5,),
        //if user show saved furniture button
        isAdmin?Container(child:null):
        listMenuButtons(
            buttonName: 'Saved Furniture',
          onPressedButton: (){}
        ),
        ElevatedButton(
            onPressed: (){
              personObject.logOut(buildContext);
            },
            child: Text("Log out"),style:ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Color(0xFF71A2B5),)),

      ],
    ),
  );
}


//4F6E7B

//73929F