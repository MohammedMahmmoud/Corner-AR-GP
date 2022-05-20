import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/user_homescreen.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = 'loadingScreen';

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);

    _myAppProvider.isLoggedUserAdmin().then((value){
      Navigator.pushReplacementNamed(context,
          value? AdminHomeScreen.routeName: UserHomeScreen.routeName);
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
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
                //height: double.infinity,
                width: double.infinity,
              ),
            ),
            const Center(
              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blueGrey,),
            )
          ],
        )

    );
  }
}
