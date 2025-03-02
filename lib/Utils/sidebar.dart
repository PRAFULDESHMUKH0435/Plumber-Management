import 'package:flutter/material.dart';
import 'package:plumber_manager/view/kaamgarscreen.dart';

class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'कामगार Manager',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            title: Text('कामगार जोडा', style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KaamGarScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}