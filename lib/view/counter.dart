import 'package:flutter/material.dart';
import 'package:plumber_manager/view-model/counterprovider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Container(
        child: Center(child: Text(provider.counter.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          provider.incrementCounter();
        }),
    );
  }
}