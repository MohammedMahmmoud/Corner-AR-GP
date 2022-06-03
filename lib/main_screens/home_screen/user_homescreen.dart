import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:corner_ar_gp/main_screens/edit_info/edit_person_info.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/bottomBar_components.dart';
import '../../components/getdata_components.dart';
import '../list_page/FurnitureListPage.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  UserHomeScreen();
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late Person loggedUser;
  late String sideMenuContent;
  int pageIndex = 0;

  List <BottomNavigationBarItem>bottomBarItems=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Add',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.auto_delete),
      label: 'Delete',
    ),
  ];

  int selectedIndex = 0;

  Future<void> onCahngedbottomBarItems(index) async {
    setState(() {
      selectedIndex = index;
    });
    if(index == 1){
      var Data = await getData("Category");
      var furnitureData = await getDataFurniture("Furniture","Category");
      print("---------------------------------------------${loggedUser.id}");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>FurnitureListPage(
              title: "Spawn Furniture",
              collectionName: "Furniture",
              furnitureInCategory: furnitureData[1],
              parentData: Data,
              dataLength: furnitureData[0].length,
              Data: furnitureData[0],
              isViewing: true,
              parentCollection: "User",
              parentID: loggedUser.id,
            ),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final _myAppProvider =  Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.name;


    return Scaffold(
      drawer: sideMenu(changeToEditPage: _setToEditPage, isAdmin: false,buildContext:context,personObject: loggedUser),
      appBar: AppBar(
        title: Text("User"),
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
          pageIndex == 1 ? EditPersonInformation(loggedUser) : const SizedBox(height: 0,)
        ],
      ),
      bottomNavigationBar: userBottomBar(
        selectedIndex: selectedIndex,
          items: bottomBarItems,
        onTap: (index)=>onCahngedbottomBarItems(index)
      ),


    );
  }

  _setToEditPage()
  {
    setState(() {
      pageIndex = 1;
    });
  }
}
