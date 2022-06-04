import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/buttons_components.dart';
import '../../person/Admin.dart';


class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'adminHomeScreen';

  AdminHomeScreen();
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late Person loggedUser;
  late String sideMenuContent;
  bool isLoading = false;

  void setIsLoading(value){
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.name;

    return Scaffold(
      drawer: sideMenu(changeToEditPage: (){}, isAdmin: true,buildContext: context, personObject:loggedUser,isLoading: (){}),
      appBar: AppBar(
        title: Text("Admin"),
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
            Column(
              children: [
                AdminHomeScreenButton(
                    pageName: "Admins List",
                    context: context,
                    collectionName: Admin.CollectionName,
                    buttonName: "Admins List",
                    isLoading: (value)=>setIsLoading(value)
                ),
                AdminHomeScreenButton(
                    pageName: "Categorios List",
                    context: context,
                    collectionName: "Category",
                    buttonName: "Category List",
                    isLoading: (value)=>setIsLoading(value)
                ),
                AdminHomeScreenButton(
                    pageName: "Furnitures List",
                    context: context,
                    collectionName: "Furniture",
                    buttonName: "Furnitures List",
                    isLoading: (value)=>setIsLoading(value)
                )
              ],
            ),
            if (isLoading) const Center(
              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blueGrey,),
            ),
          ],
        )

    );
  }
}
