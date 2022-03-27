import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/drawer_component.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  UserHomeScreen();
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late Person loggedUser;
  late String sideMenuContent;


  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.name;

    return Scaffold(
      drawer: sideMenu(isAdmin: false,userName: sideMenuContent,buildContext:context,personObject: loggedUser),
      appBar: AppBar(
        title: Text("User"),
      ),


    );
  }
}
