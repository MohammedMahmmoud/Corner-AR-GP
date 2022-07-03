// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:palette_generator/palette_generator.dart';
// import 'dart:async';
//
//
//
// class DisplayPictureScreen extends StatefulWidget {
//   final String imagePath;
//   DisplayPictureScreen(this.imagePath);
//
//   @override
//   State<DisplayPictureScreen> createState() => _DisplayPictureScreenState(this.imagePath);
// }
//
// class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
//   final String imagePath;
//
//   _DisplayPictureScreenState(this.imagePath);
//
//   late PaletteGenerator paletteGenerator;
//
//   final GlobalKey imageKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     _updatePaletteGenerator();
//   }
//
//   Future<void> _updatePaletteGenerator() async {
//     paletteGenerator = await PaletteGenerator.fromImageProvider(
//       widget.image,
//       size: widget.imageSize,
//       maximumColorCount: 20,
//     );
//     print("--------------------------------------------------------------------------");
//     print("palette generator:");
//     print(paletteGenerator.paletteColors[0].color);
//     print(paletteGenerator.darkMutedColor);
//     setState(() {});
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Display the Picture')),
//         body:GridView.count(
//       crossAxisCount: 2,
//       children: List.generate(paletteGenerator.paletteColors.length, (index) {
//         return ElevatedButton(
//           onPressed: () {  },
//           child: Container(
//             color: paletteGenerator.lightMutedColor?.color,
//           ),
//         );
//       }),)
//     );
//   }
// }
