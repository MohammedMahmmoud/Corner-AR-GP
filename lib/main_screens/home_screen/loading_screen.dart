import 'package:camera/camera.dart';
import 'package:corner_ar_gp/ColorDetection/Camera/camera.dart';
import 'package:corner_ar_gp/main_screens/home_screen/admin_homescreen.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = 'loadingScreen';

  @override
  Widget build(BuildContext context) {
    late final _myAppProvider =  Provider.of<AppProvider>(context);
    // List<CameraDescription> cameras = [];
    // WidgetsFlutterBinding.ensureInitialized();
    //
    // availableCameras().then((theValue) => {
    //   _myAppProvider.isLoggedUserAdmin().then((value){
    //
    //     Navigator.pushReplacement<void, void>(
    //       context,
    //       value?MaterialPageRoute<void>(
    //           builder: (BuildContext context) => AdminHomeScreen()
    //       ):MaterialPageRoute<void>(
    //         builder: (BuildContext context) => Camera(theValue),
    //       ),
    //     );
    //
    //     // Navigator.pushReplacementNamed(context,
    //     //     value? AdminHomeScreen.routeName: MyCamera(cameras));
    //   })
    // });

    _myAppProvider.isLoggedUserAdmin().then((value)async{
      WidgetsFlutterBinding.ensureInitialized();
      List<CameraDescription> cameras = await availableCameras();
      print("ccccccccccccccccccccaaaaaaaaaammmmmmmmmmmmeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      Navigator.pushReplacement<void, void>(
        context,
        value?MaterialPageRoute<void>(
          builder: (BuildContext context) => AdminHomeScreen()
        ):MaterialPageRoute<void>(
          builder: (BuildContext context) => Camera(cameras),
        ),
      );

      // print("theeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      // Navigator.pushReplacementNamed(context,
      //     value? AdminHomeScreen.routeName: Camera.routeName);
      // print("theeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
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
