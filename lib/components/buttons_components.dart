import 'package:flutter/material.dart';

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