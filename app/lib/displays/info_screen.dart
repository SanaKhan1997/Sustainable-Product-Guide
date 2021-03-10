import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#3c5949"),
        title: Text('Eco-friendly Tags'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('row $index'),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: 10),
    );
  }
}
