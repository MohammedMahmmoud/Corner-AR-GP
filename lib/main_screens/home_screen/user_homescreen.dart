import 'package:corner_ar_gp/components/drawer_component.dart';
import 'package:corner_ar_gp/main_screens/edit_info/edit_person_info.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../color_picker/ColorPicker.dart';
import '../../components/getdata_components.dart';
import '../list_page/FurnitureListPage.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';
  late var paletteGenerator;
  UserHomeScreen(this.paletteGenerator);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState(this.paletteGenerator);
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late var paletteGenerator;
  _UserHomeScreenState(this.paletteGenerator);
  late Person loggedUser;
  late String sideMenuContent;
  int pageIndex = 0;
  bool isLoading = false;
  Color currentColor = Colors.amber;

  //late UnityWidgetController _unityWidgetController;
  void changeColor(Color color) => setState(() => currentColor = color);


  void setIsLoading(value){
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _myAppProvider =  Provider.of<AppProvider>(context);
    loggedUser = _myAppProvider.getLoggedUser();
    sideMenuContent = loggedUser.name;


    return Scaffold(
      drawer: sideMenu(
          changeToEditPage:_setToEditPage,
          isAdmin: false,
          buildContext:context,
          personObject:loggedUser,
          isLoading: (value)=>setIsLoading(value)
      ),
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
          // Container(
          //   height: 500,
          //   color: Colors.yellowAccent,
          //   child: UnityWidget(
          //     onUnityCreated: onUnityCreated,
          //     onUnityMessage: onUnityMessage,
          //     fullscreen: false,
          //   ),
          // ),
          Container(
            child:ColorPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
              paletteColors: paletteGenerator
            ),
          ),
          pageIndex == 1 ? EditPersonInformation(loggedUser) : const SizedBox(height: 0,),
          if (isLoading) const Center(
            child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blueGrey,),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setIsLoading(true);
          var Data = await getData("Category");
          var furnitureData = await getDataFurniture("Furniture","Category");
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
                ),
              )
          );
          setIsLoading(false);
        }
        ,child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
  _setToEditPage()
  {
    setState(() {
      pageIndex = 1;
    });
  }

  // Callback that connects the created controller to the unity controller
  // void onUnityCreated(controller) {
  //   this._unityWidgetController = controller;
  // }
  //
  // void onUnityMessage(message) {
  //   print('Received message from unity: ${message.toString()}');
  // }
}
