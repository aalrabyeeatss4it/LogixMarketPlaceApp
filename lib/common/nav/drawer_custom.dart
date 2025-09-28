import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          ListTile(
            title: Text("home"),
            leading: Icon(Icons.add),
          ),
          ListTile(
            title: Text("home"),
            leading: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
