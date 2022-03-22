import 'package:flutter/material.dart';

TextFormField textFormFieldComponent(
{
  required String hintText,
  required Function onChangedText,
  required Function validator,
  /*required bool passwordIcon,
  bool? isPasswordHidden,*/
}
    ){
  return TextFormField(
    onChanged: (newValue){
      onChangedText(newValue);
    },
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFbdc6cf)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color:Color(0xFFbdc6cf)),
      ),
        /*suffixIcon: IconButton(
          icon: Icon(isPasswordHidden?
          Icons.visibility_off_outlined:
          Icons.visibility_outlined,color: Color(0xFFbdc6cf),),
          onPressed: (){
            isPasswordHidden = !isPasswordHidden;
            setState(() {});
          },
        )*/
    ),
    validator: (value) => validator(value),
    style: const TextStyle(color: Color(0xFFbdc6cf)),

  );
}

