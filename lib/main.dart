import 'package:corner_ar_gp/authentication/registration/registration_screen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/user_homescreen.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/login/LoginPage.dart';
import 'main_screens/home_screen/loading_screen.dart';


/** debug token D7C96657-48AD-422C-BEE2-49A12E387376  **/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  // );

  await FirebaseAppCheck.instance.activate();
  String? token = await FirebaseAppCheck.instance.getToken();
  print("------------===========================----------- $token");
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  FirebaseAppCheck.instance.onTokenChange.listen((token) {
  print("==========================>>>>>>>>>>>>>>>> $token");
  });

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AppProvider(),
      builder: (context,widget) {
        final myAppProvider = Provider.of<AppProvider>(context);
        final isUserLoggedIn = myAppProvider.checkLoggedUser();
        bool isAdmin = false;
        if(isUserLoggedIn){
          myAppProvider.fetchLoggedUser();
          // isAdmin = myAppProvider.isLoggedUserAdmin();
          // print("===>  $isAdmin");
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {

            RegistrationScreen.routeName: (context) =>
                RegistrationScreen(isAdmin: false),
            Login.routeName: (context) => Login(),
            UserHomeScreen.routeName: (context) => UserHomeScreen(),
            AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
            LoadingScreen.routeName: (context) =>LoadingScreen()
          },
          initialRoute: isUserLoggedIn?
              //isAdmin? AdminHomeScreen.routeName : UserHomeScreen.routeName
          LoadingScreen.routeName
          : Login.routeName,
        );
      }
    );
  }
}
