import 'package:flutter/material.dart';

BottomNavigationBar userBottomBar({
  required List<BottomNavigationBarItem> items,
  required int selectedIndex,
  required Function onTap,

}){
  return BottomNavigationBar(
    items: items,
    currentIndex: selectedIndex,


    selectedItemColor: Color(0xFFF87217),
    unselectedItemColor: Colors.grey,
    onTap: (index)=>onTap(index),
  );
}