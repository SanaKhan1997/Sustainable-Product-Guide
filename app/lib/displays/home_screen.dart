import 'package:app/data_models/product.dart';
import 'package:app/displays/product_display.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget products = new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error in retreiving data: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Not connected to the Stream or null');

            case ConnectionState.waiting:
              return new Text('Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              var productCount = 0;
              List<DocumentSnapshot> productSnapshot;

              if (snapshot.hasData) {
                productSnapshot = snapshot.data.docs;
                productCount = productSnapshot.length;

                if (productCount > 0) {
                  return new GridView.builder(
                      itemCount: productCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Card(
                            child: InkWell(
                              splashColor: Colors.black,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                            product: Product.fromJSON(
                                                productSnapshot[index].data(),
                                                productSnapshot[index].id))));
                              },
                              child: Container(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                    ClipRect(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: new CachedNetworkImage(
                                          maxHeightDiskCache: 208,
                                          filterQuality: FilterQuality.low,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          imageUrl: productSnapshot[index]
                                              .get('productImages'),
                                        ),
                                      ),
                                    ),
                                  ])),
                            ),
                          ),
                        );
                      });
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
        title: Text('Home'),
        backgroundColor: HexColor("#3c5949"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            products,
          ],
        ),
      ),
    );
  }
}
