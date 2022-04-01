import 'package:corner_ar_gp/components/buttons_components.dart';
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
    child: Column(
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
            onPressedButton: ()=>changeToEditPage()
        ),
        const SizedBox(height: 5,),
        //if user show saved furniture button
        isAdmin?Container(child:null):
        listMenuButtons(
            buttonName: 'Saved Furniture',
          onPressedButton: (){}
        ),
        TextButton.icon(
            onPressed: (){
              personObject.logOut(buildContext);
            },
            icon: ImageIcon(
              AssetImage("assets/log_out.png"),
              color: Colors.white,
              size: 40,
            ),
            label: Text("Log out",style: TextStyle(fontSize: 20),),
            style:TextButton.styleFrom(
              primary: Colors.white,
            )
        ),
      ],
    ),
  );
}