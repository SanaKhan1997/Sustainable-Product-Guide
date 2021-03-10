import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: HexColor("#3c5949"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(26, (index) {
          return Container(
            child: Card(
              color: Theme.of(context).popupMenuTheme.color,
            ),
          );
        }),
      ),
    );
  }
}
