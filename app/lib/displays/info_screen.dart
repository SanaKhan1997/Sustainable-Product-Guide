import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../routes.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget labelWidget = new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('labels').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              var labelCount = 0;
              List<DocumentSnapshot> labelSnapshot;

              if (snapshot.hasData) {
                labelSnapshot = snapshot.data.docs;
                labelCount = labelSnapshot.length;

                if (labelCount > 0) {
                  return new Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ExpansionTile(
                        leading: Icon(Icons.label, color: Colors.black),
                        trailing: Text(
                          labelCount.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        title: Text("Eco-friendly Labels",
                            style: TextStyle(color: Colors.black)),
                        initiallyExpanded: true,
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: labelCount,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Card(
                                    color: HexColor('#E4DBDB'),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRect(
                                                child: new CachedNetworkImage(
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.fitWidth,
                                                  placeholder: (context, url) =>
                                                      new LinearProgressIndicator(
                                                    backgroundColor:
                                                        Colors.black,
                                                    minHeight: 8,
                                                  ),
                                                  imageUrl: labelSnapshot[index]
                                                      .get('labelImage'),
                                                ),
                                              ),
                                              Text(
                                                labelSnapshot[index]
                                                    .get('labelName'),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                                labelSnapshot[index]
                                                    .get('labelDescription'),
                                                style: TextStyle(fontSize: 18)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ]),
                  );
                }
              }
              return new Container(
                color: Colors.grey,
                alignment: Alignment.centerLeft,
                height: size.height * 0.2,
                child: Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    new Text(
                      'No labels found',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            case ConnectionState.done:
              return new Text('Streaming is done');
          }
          return Container(
            child: new Text('No comments found'),
          );
        });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#3c5949"),
          title: Text('Eco-friendly Tags'),
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
        body: SingleChildScrollView(child: labelWidget));
  }
}
