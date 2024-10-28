import 'package:flutter/material.dart';

class BottomItem {
  final Icon icon;
  final String iconName;

  BottomItem({required this.icon, required this.iconName});


   static List<BottomNavigationBarItem> buildBottomList(List<BottomItem> bottomItems) {
    return bottomItems
        .map((item) => BottomNavigationBarItem(icon: item.icon, label: item.iconName))
        .toList();
  }
}

List<BottomItem> bottomTitles = [
  BottomItem(icon: const Icon(Icons.store), iconName: 'Store',),
  //BottomItem(icon: const Icon(Icons.search), iconName: 'Search'),
  BottomItem(icon: const Icon(Icons.favorite), iconName: 'Favorites'),
];


//