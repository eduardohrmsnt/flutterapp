import 'package:flutter/material.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 20,),
          Center(child: Text('AjudaEu', style: TextStyle(fontSize: 18),)),
          SizedBox(height: 20,),
          Column(
            children: [
              const DrawerTile(iconData: Icons.home, title: 'Empresas', page: 0),
              const DrawerTile(iconData: Icons.home, title: 'Atividades', page: 1),
            ],
          )
        ],
      ),
    );
  }
}
