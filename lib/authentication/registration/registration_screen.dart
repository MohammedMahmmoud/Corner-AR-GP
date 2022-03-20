import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/person/User.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'registration';
  bool isAdmin;
  RegistrationScreen({this.isAdmin = false});
  @override
  _registrationScreenState createState() => _registrationScreenState(isAdmin);
}

class _registrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  Person person = Person();
  String password = '';
  bool isAdmin;
  bool isPasswordHidden = true;

  _registrationScreenState(this.isAdmin) {
    person = isAdmin? Admin() : User();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'First Name'
                    ),
                    onChanged: (value){
                      person.setFirstName(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Last Name'
                    ),
                    onChanged: (value){
                      person.setLastName(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email Address'
                    ),
                    onChanged: (value){
                      person.setEmail(value);
                    },
                    validator: (value) => person.mailValidator(value),
                  ),
                  TextFormField(
                    obscureText: isPasswordHidden? true : false,

                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordHidden?
                        Icons.visibility_off_outlined:
                        Icons.visibility_outlined),
                        onPressed: (){
                          isPasswordHidden = !isPasswordHidden;
                          setState(() {});
                        },
                      ),
                    ),
                    onChanged: (value){
                      password = value;
                    },
                    validator: (value) => person.passwordValidator(value),
                  ),
                  ElevatedButton(
                    onPressed: ()=>person.registration(_formKey, password, isAdmin),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
