import 'package:corner_ar_gp/person/Admin.dart';
import 'package:flutter/material.dart';

import '../list_page/ListPage.dart';
import 'getdata_components.dart';

ElevatedButton LogAndRegisterButton(
{
  required String buttonText,
  required VoidCallback onPressedButton
}
    ){
  return ElevatedButton(
    onPressed: onPressedButton,
    child: Text(
      buttonText,
      style: TextStyle(
        fontSize: 22,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: Color(0xFF71A2B5),
      fixedSize: const Size(200, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
    ),
  );
}

ElevatedButton AdminHomeScreenButton(
{
  required String collectionName,
  required BuildContext context,
  required String buttonName,
  required String pageName
}
    ){
  var Data;

  return ElevatedButton(
      onPressed: ()async{
        Data = await getData(collectionName);
        print("innnnnnnished");
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ListPage(title:pageName,collectionName:collectionName, Data: Data,dataLength: Data.length),));
      },
      child: Text(buttonName));
}



Container listMenuButtons(
{
  required String buttonName,
  required VoidCallback onPressedButton
}
    ){
  return Container(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
        onPressed: onPressedButton,
        child: Text(buttonName,style: TextStyle(fontSize: 20),),
        style:ElevatedButton.styleFrom(
          primary: Color(0xFF4F6E7B),
          onPrimary: Colors.white,
        )
    ),
  );
}