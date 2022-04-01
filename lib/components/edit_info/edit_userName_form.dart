import 'package:corner_ar_gp/components/textField_components.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:flutter/cupertino.dart';

Container EditUserNameForm({required Person person, required GlobalKey<FormState> formKey})
{
  _defaultValidator (value) {
    print('========================='+person.id+'============================');
    if (value == null || value.isEmpty) {
      return 'Please enter last name';
    }
    return null;
  }

  return Container(
    child: Form(
      key: formKey,
      child: Column(
        children: [
          textFormFieldComponent(
            hintText: 'First Name',
            onChangedText: person.setFirstName,
            validator: _defaultValidator,
            isPasswordTextForm: false
          ),
          const SizedBox(height: 5,),
          textFormFieldComponent(
            hintText: 'Last Name',
            onChangedText: person.setLastName,
            validator: _defaultValidator,
            isPasswordTextForm: false
          ),
          const SizedBox(height: 5,),
        ],
      ),
    ),
  );


}