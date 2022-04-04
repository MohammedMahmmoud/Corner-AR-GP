import 'package:flutter/material.dart';

Card TileEditCard({required String cardTitle, required Function onTapFunction, int iconState = 0}) {
  final icons = [
    const Icon(Icons.arrow_forward_ios_rounded,color: Color(0xFF000000),),
    const Icon(Icons.bookmark_added_outlined ,color: Color(0xFF000000),),
    const Icon(Icons.error_outline ,color: Color(0xFF820000),),
    const Icon(Icons.done_outline_rounded ,color: Color(0xFF46A13E),)
  ];
  return Card(
      elevation: 0,
      color: Colors.transparent,
      //margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Container(
        //margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFF404040)),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],

        ),
        child: ListTile(
          //isThreeLine: true,
          minVerticalPadding: 24,
          title: Text(cardTitle, style: const TextStyle(color: Color(0xFF2A2929)),),
          onTap: () => onTapFunction(),
          trailing: icons[iconState],
          //subtitle: Text('Here is a second line'),
        ),
      ),
  );
}