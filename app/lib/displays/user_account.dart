import 'package:app/data_models/user.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  Future<Users> user = DatabaseProvider()
      .getUser(FirebaseAuth.instance.currentUser.uid.toString());

  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: HexColor("#3c5949"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.house_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.add_box), label: 'Add Product'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.account_box_rounded), label: 'Profile'),
        ],
        onTap: (int item) async {
          switch (item) {
            case 0:
              return Navigator.of(context).pushNamed(Routes.HomeRoute);
            case 1:
              return Navigator.of(context).pushNamed(Routes.ProductPostRoute);
            case 2:
              return Navigator.of(context).pushNamed(Routes.ProfileRoute);
          }
        },
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('User Name:'),
                        Padding(padding: EdgeInsets.all(20)),
                        SizedBox(
                          child: Text('test user'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('User Email:'),
                        Padding(padding: EdgeInsets.all(20)),
                        SizedBox(
                          child: Text(FirebaseAuth.instance.currentUser.email
                              .toString()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
