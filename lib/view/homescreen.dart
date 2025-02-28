import 'package:flutter/material.dart';
import 'package:plumber_manager/Utils/sidebar.dart';
import 'package:plumber_manager/view-model/kaamhgarprovider.dart';
import 'package:plumber_manager/view/kaamgardetailsscreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plumber Manager'),
        backgroundColor: Colors.red,
      ),
      drawer: SidebarNavigation(),
      body: Consumer<KaamGarProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.kaamGarList.length,
            itemBuilder: (context, index) {
              final kaamgar = provider.kaamGarList[index];
              print("Each KaamGar Is : $kaamgar");
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(kaamgar),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KaamGarDetailsScreen(kaamGar: kaamgar),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}