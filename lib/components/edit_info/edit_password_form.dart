import 'package:corner_ar_gp/components/textField_components.dart';
import 'package:corner_ar_gp/main_screens/edit_info/edit_person_info.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:flutter/cupertino.dart';

Container EditPasswordForm({
  required Person person,
  required PrimitiveWrapper password,
  required PrimitiveWrapper newPassword,
  required Function currentPasswordValidator,
  required Function toggleCurrentPasswordVisibility,
  required Function toggleNewPasswordVisibility,
  required GlobalKey<FormState> formCurrentKey,
  bool hideCurrentPassword = true,
  bool hideNewPassword = true
}){
  final passwordFormKey = GlobalKey<FormState>();
  String? _password, _confirmedPassword;
  String? _validatePassword(String? value){
    return value!.length < 6 ? 'password length must be greater than 6' : null;
  }
  String? _validateConfirmedPassword(String? value){
    String? message;
    if(value != _password) {
        message = 'Password confirmation does not match the password';
      }
    if(value!.length < 6){
      message = 'password length must be greater than 6';
    }
    if(message == null){
      newPassword.value=value;
    }
    return message;
  }

  void _setPassword(String pass){
    _password = pass;
  }


  return Container(
    child: Column(
      children: [
        Form(
          key: formCurrentKey,
          child: textFormFieldComponent(
                  hintText: 'Current Password',
                  onChangedText: (value) => (){password.value += value;},
                  validator: currentPasswordValidator,
                  isPasswordTextForm: true,
                  isPasswordHidden: hideCurrentPassword,
                  togglePasswordVisibility: toggleCurrentPasswordVisibility
            ),
        ),
        Form(
          key: passwordFormKey,
          child: Column(
            children: [
              const SizedBox(height: 5,),
              textFormFieldComponent(
                  hintText: 'New Password',
                  onChangedText: (value)=> (){_password = value;},
                  validator: _validatePassword,
                  isPasswordTextForm: true,
                  isPasswordHidden: hideNewPassword,
                  togglePasswordVisibility: toggleNewPasswordVisibility
              ),
              const SizedBox(height: 5,),
              textFormFieldComponent(
                  hintText: 'Confirm Password',
                  onChangedText: (){},
                  validator: _validateConfirmedPassword,
                  isPasswordTextForm: true,
                  isPasswordHidden: hideNewPassword,
                  togglePasswordVisibility: toggleNewPasswordVisibility
              ),
              const SizedBox(height: 5,),
            ],
          ),
        ),
      ],
    ),
  );

}
