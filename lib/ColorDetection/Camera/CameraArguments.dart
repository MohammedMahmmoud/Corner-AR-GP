import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

Future<CameraController> cameraControllerIntillaizer() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  CameraController cameraController = CameraController(cameras[0], ResolutionPreset.medium);
  cameraController.initialize().then((value){});
  return cameraController;
}