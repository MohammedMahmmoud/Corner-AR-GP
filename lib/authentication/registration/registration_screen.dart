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
      body: Stack(
        children: [
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/backgroundBottom.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            child: Image.asset(
              'assets/backgroundTop.png',
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(30, 80, 30, 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset('assets/logAndRegisterIcon.png'),
                        ),
                        const SizedBox(height: 70),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'First Name'
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
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Last Name'
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
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Email Address'
                          ),
                          onChanged: (value){
                            person.setEmail(value);
                          },
                          validator: (value) => person.mailValidator(value),
                        ),
                        const SizedBox(height: 10),
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(70,80,70,0),
                          child: ElevatedButton(
                            onPressed: ()=>person.registration(_formKey, password, isAdmin),
                            child: const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 22,
                                //color: Color(0xFF71A2B5)
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xFF71A2B5),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),

                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
