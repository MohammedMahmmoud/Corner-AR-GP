import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  String uid;
  UserHomeScreen(this.uid);
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState(uid);
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late Person loggedUser;

  String uid;
  _UserHomeScreenState(this.uid);
  late String sideMenuContent=uid;

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.id;

    return Scaffold(
      drawer: sideMenu(isAdmin: false,userName: sideMenuContent),
      appBar: AppBar(
        title: Text("User"),
      ),


    );
  }
}
