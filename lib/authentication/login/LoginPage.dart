import 'package:corner_ar_gp/authentication/registration/registration_screen.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/person/User.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  static const routeName = 'login';
  bool isAdmin;
  Login({this.isAdmin = false});
  @override
  _LoginState createState() => _LoginState(isAdmin);
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  Person person = Person();
  String password = '';
  bool isPasswordHidden = true;
  _LoginState(bool isAdmin){
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
              padding: const EdgeInsets.fromLTRB(30, 170, 30, 12),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset('assets/logAndRegisterIcon.png'),
                            ),
                            const SizedBox(height: 70),
                            TextFormField(
                              onChanged: (newValue){
                                person.setEmail(newValue);
                              },
                              decoration: const InputDecoration(
                                hintText: "Email",
                              ),
                              validator: (value) => person.mailValidator(value),
                              style: TextStyle(color: const Color(0xFFbdc6cf)),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: isPasswordHidden? true : false,
                              onChanged: (newValue){
                                password=newValue;
                              },
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
                              validator: (value) => person.passwordValidator(value),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(70,80,70,0),
                        child: ElevatedButton(
                          onPressed: () => person.logIn(_loginFormKey, password,context),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 22
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
                      Container(
                        child: TextButton(
                          onPressed: () {  },
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 50, 15, 12),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegistrationScreen.routeName);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54
                              //color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ],
        )
    );
  }
}
