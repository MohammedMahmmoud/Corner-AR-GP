import 'package:camera/camera.dart';
import 'package:corner_ar_gp/ColorDetection/Camera/camera.dart';
import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/main_screens/home_screen/user_homescreen.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/getdata_components.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = 'loadingScreen';

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);

    _myAppProvider.isLoggedUserAdmin().then((value)async{
      WidgetsFlutterBinding.ensureInitialized();
      List<CameraDescription> cameras = await availableCameras();
      var Data = await getData("Admin");
      var categoryData = await getData("Category");
      var furnitureData = await getDataFurniture("Furniture","Category");
      Navigator.pushReplacement<void, void>(
        context,
        value?MaterialPageRoute<void>(
          builder: (BuildContext context) => AdminHomeScreen(Data,categoryData,furnitureData,0,"Admin List")
        ):MaterialPageRoute<void>(
          builder: (BuildContext context) => Camera(cameras),
        ),
      );
    });


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF87217)
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
              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.orange,),
            )
          ],
        )

    );
  }
}
