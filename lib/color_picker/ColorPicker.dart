import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final List paletteColors;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    required this.paletteColors
  }) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  double _borderRadius = 30;
  double _iconSize = 24;
  bool colorsListExist=false;
  int size=0;


  Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
    if(widget.paletteColors.isNotEmpty)
      size = widget.paletteColors.length;
    return SizedBox(
      height: 100,
      child: size!=0?GridView.count(
        crossAxisCount: size,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [for (Color color in widget.paletteColors) child(color)],//:Text("None"),
      ):Container(child: const Text("None"),padding: const EdgeInsets.fromLTRB(15.0,0.0,0.0,0.0),),
    );
  }

  Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: _iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(0),
                  contentPadding: const EdgeInsets.all(0),

                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HueRingPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                        ),
                        Container(child: const Text("Suggested Colors:"),padding: const EdgeInsets.all(10.0),),
                        BlockPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text(
            'Hue Ring Picker with Hex Input',
            style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            primary: widget.pickerColor,
            shadowColor: widget.pickerColor.withOpacity(1),
            elevation: 10,
          ),
        ),
      ],
    );
  }
}