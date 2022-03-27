import 'package:corner_ar_gp/authentication/registration/registration_screen.dart';
import 'package:corner_ar_gp/home_screen/user_homescreen.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/login/LoginPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

        return MaterialApp(
          routes: {
            RegistrationScreen.routeName: (context) =>
                RegistrationScreen(isAdmin: false),
            Login.routeName: (context) => Login(isAdmin: false),
            UserHomeScreen.routeName: (context) => UserHomeScreen(),
          },
          initialRoute: isUserLoggedIn?
          UserHomeScreen.routeName:
          Login.routeName,
        );
      }
    );
  }
}
