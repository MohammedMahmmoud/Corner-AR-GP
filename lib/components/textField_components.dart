import 'package:flutter/material.dart';

TextFormField textFormFieldComponent(
{
  required String hintText,
  required Function onChangedText,
  required Function validator,
  required bool isPasswordTextForm,
  String? initialValue,
  bool isPasswordHidden = false,
  Function? togglePasswordVisibility
}
    ){
  return TextFormField(
    initialValue: initialValue,
    obscureText: isPasswordHidden,
    onChanged: (newValue){
      onChangedText(newValue);
      print("----------------------------------------------------------new value: $newValue");
    },
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFbdc6cf)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color:Color(0xFFbdc6cf)),
      ),
        suffixIcon: isPasswordTextForm? IconButton(
          icon: Icon(isPasswordHidden?
          Icons.visibility_off_outlined:
          Icons.visibility_outlined,color: Color(0xFFbdc6cf),),
          onPressed: () => togglePasswordVisibility!()
        ) : const Icon(
          Icons.import_contacts_sharp,
          color: Colors.transparent,
          size: 0,
        )
    ),
    validator: (value) => validator(value),
    style: const TextStyle(color: Colors.black),

  );
}

