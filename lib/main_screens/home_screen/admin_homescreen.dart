import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/buttons_components.dart';
import '../../person/Admin.dart';
import '../list_page/FurnitureListPage.dart';
import '../list_page/ListPage.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'adminHomeScreen';
  var adminData;
  var categoryData;
  var furnitureData;
  int _selectedIndex;
  String title;
  AdminHomeScreen(this.adminData,this.categoryData,this.furnitureData,this._selectedIndex,this.title);
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState(adminData,categoryData,furnitureData,_selectedIndex,title);
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var adminData;
  var categoryData;
  var furnitureData;
  String title;
  int _selectedIndex = 0;
  _AdminHomeScreenState(this.adminData,this.categoryData,this.furnitureData,this._selectedIndex,this.title);
  late Person loggedUser;
  late String sideMenuContent;
  bool isLoading = false;


  late final List<Widget> _widgetOptions = <Widget>[
      ListPage(
        title:"Admins List",
        collectionName:Admin.CollectionName,
        Data: adminData,
        dataLength: adminData.length,
        loggeduser: loggedUser,
    ),
    Container(
      child: ListPage(
          title:"Category List",
          collectionName:"Category",
          Data: categoryData,
          dataLength: categoryData.length,
      ),
    ),
    FurnitureListPage(
      spawned: false,
      title: "Furniture List",
      collectionName:"Furniture",
      Data: furnitureData[0],
      dataLength: furnitureData[0].length,
      parentData: categoryData,
      furnitureInCategory: furnitureData[1],
      isViewing: false,
      parentCollection: "Category",
      parentID: "",
    ),
  ];

  void setIsLoading(value) {
    setState(() {
      isLoading = value;
    });
  }

  void _onItemTapped(int index) async{
    setIsLoading(true);
    if(index == 0){
      title = "Admins List";
    }else if(index == 1){
      title = "Categories List";
    }else if(index == 2){
      title = "Furniture List";
    }
    setState(() {
      _selectedIndex = index;
    });
    setIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider = Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.name;



    return Scaffold(
      drawer: sideMenu(
          isAdmin: true,
          buildContext: context,
          personObject: loggedUser,
          isLoading: () {}),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFFF87217),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/backgroundTop.png',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.orange,),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_delete),
            label: 'Furniture',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF87217),
        selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
        unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
