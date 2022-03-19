import 'package:corner_ar_gp/authentication/preson_class.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = 'registration';
  final _formKey = GlobalKey<FormState>();
  Person person = Person();
  String firstName = '', lastName = '', email = '', password = '';

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
                      firstName = value;
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
                      lastName = value;
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
                      email = value;
                      person.setEmail(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password'
                    ),
                    onChanged: (value){
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: ()=>person.registration(_formKey, password),
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