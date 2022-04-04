import 'package:corner_ar_gp/components/textField_components.dart';
import 'package:flutter/cupertino.dart';

Container EditEmailForm({
  required GlobalKey<FormState> formKey,
  required Function emailReturner,
  required Function passReturner,
  required Function emailValidator,
  required Function passwordValidator,
  required Function togglePasswordVisibility,
  bool hidePassword = true,
  String? emailSavedValue
})
{
  return Container(
    padding: const EdgeInsets.only(top: 8, right: 18, left: 14, bottom: 10),
    child: Form(
      key: formKey,
      child: Column(
        children: [
          textFormFieldComponent(
              hintText: 'New Email Address',
              onChangedText: (value) => emailReturner(value),
              validator: emailValidator,
              isPasswordTextForm: false,
              initialValue: emailSavedValue
          ),
          const SizedBox(height: 5,),
          textFormFieldComponent(
              hintText: 'Enter Password',
              onChangedText: (value) => passReturner(value),
              validator: passwordValidator,
              isPasswordTextForm: true,
              togglePasswordVisibility: togglePasswordVisibility,
              isPasswordHidden: hidePassword,
          ),
        ],
      ),
    ),
  );


}
