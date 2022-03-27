import 'package:flutter/material.dart';

Drawer sideMenu(
{
  required String userName,
  required bool isAdmin
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
        Container(child: ElevatedButton(onPressed: (){}, child: Text("Edit Profile"),style:ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Color(0xFF71A2B5),))),
        Container(child: ElevatedButton(onPressed: (){}, child: Text("Edit Profile"),style:ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xFF71A2B5),))),
        Container(child: ElevatedButton(onPressed: (){}, child: Text("Edit Profile"),style:ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xFF71A2B5),))),
      ],
    ),
  );
}