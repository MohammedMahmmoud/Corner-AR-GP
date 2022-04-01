import 'package:flutter/material.dart';

Card TileEditCard({required String cardTitle, required Function onTapFunction}) {
  return Card(
    child: ListTile(
      title: Text(cardTitle),
      onTap: () => onTapFunction()
      //subtitle: Text('Here is a second line'),
    ),
  );
}