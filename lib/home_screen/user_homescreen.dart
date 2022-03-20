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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                sideMenuContent,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("User"),
      ),


    );
  }
}
