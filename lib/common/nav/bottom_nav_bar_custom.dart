import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarCustom extends StatelessWidget {
  BottomNavBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: barItems);
  }

  final List<BottomNavigationBarItem> barItems = [
    const BottomNavigationBarItem(label: "home",icon: Icon(Icons.home)),
    const BottomNavigationBarItem(label: "services",icon: Icon(Icons.design_services)),
    const BottomNavigationBarItem(label: "cart",icon: Icon(Icons.shopping_cart)),
  ];
}
