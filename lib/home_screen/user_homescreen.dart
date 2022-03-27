import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  String uid;
  UserHomeScreen(this.uid);
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState(uid);
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  String uid;
  _UserHomeScreenState(this.uid);
  late String sideMenuContent=uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideMenu(isAdmin: false,userName: sideMenuContent),
      appBar: AppBar(
        title: Text("User"),
      ),


    );
  }
}
