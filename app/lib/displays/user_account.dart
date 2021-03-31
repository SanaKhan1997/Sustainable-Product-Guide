import 'package:app/data_models/user.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../routes.dart';

@immutable
class ProfileScreen extends StatefulWidget {
  final Users current;
  ProfileScreen({Key key, this.current}) : super(key: key);

  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget userDetails = new StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error in retrieving data: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Not connected to the Stream or null');

            case ConnectionState.waiting:
              return new Text('Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              if (snapshot.hasData) {
                Users currentUser =
                    Users.fromJSON(snapshot.data.data(), snapshot.data.id);
                if (currentUser != null) {
                  return new ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Center(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight: size.height * 0.4,
                                    minWidth: size.width,
                                  ),
                                  child: ClipRRect(
                                    child: new CachedNetworkImage(
                                      fit: BoxFit.fitWidth,
                                      imageUrl: currentUser.userImage,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  alignment: Alignment.centerLeft,
                                  width: size.width,
                                  height: size.height * 0.06,
                                  color: HexColor("#3c5949"),
                                  child: Text(
                                    'User Information',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.centerLeft,
                                    width: size.width,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Full Name: '),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Container(
                                              child: Text(
                                                '${currentUser.firstName} ${currentUser.lastName}',
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(10)),
                                        Row(
                                          children: [
                                            Text('Email Address: '),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Container(
                                              child: Text(
                                                '${currentUser.email}',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                      ]);
                }
              }
              return new Center(
                child: Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 50),
                    ),
                    new Text('No products found'),
                  ],
                ),
              );
            case ConnectionState.done:
              return new Text('Streaming is done');
          }
          return Container(
            child: new Text('No products found'),
          );
        });
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
        selectedItemColor: HexColor("#3c5949"),
        unselectedItemColor: HexColor("#3c5949"),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.house_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.add_box), label: 'Add Product'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.eco_sharp), label: 'About Labels'),
        ],
        onTap: (int item) async {
          switch (item) {
            case 0:
              return Navigator.of(context).pushNamed(Routes.HomeRoute);
            case 1:
              return Navigator.of(context).pushNamed(Routes.ProductPostRoute);
            case 2:
              return Navigator.of(context).pushNamed(Routes.InfoRoute);
          }
        },
      ),
      body: SingleChildScrollView(
        child: new Container(
            child: new Column(children: <Widget>[
          Container(color: Colors.white, child: userDetails)
        ])),
      ),
    );
  }
}
