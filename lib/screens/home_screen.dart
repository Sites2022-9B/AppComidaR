import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontsize30 = const TextStyle(fontSize: 30);
    int counter = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('homeScreen'),
        elevation: 0,
      ),
      // backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total de clicks', style: fontsize30),
            Text('$counter', style: fontsize30),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.ac_unit),
        onPressed: () {
          counter++;
          print('holamundo: $counter');
        },
      ),
    );
  }
}
