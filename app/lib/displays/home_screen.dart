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
  List _allProducts = [];
  int _counter = 0;
  TextEditingController _searchController = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChange);
  }

  void dispose() {
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
    super.dispose();
  }

  getProducts() async {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

  _onSearchChange() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget products = new StreamBuilder<QuerySnapshot>(
        stream: _searchController.text.isEmpty
            ? FirebaseFirestore.instance.collection('products').snapshots()
            : FirebaseFirestore.instance
                .collection('products')
                .where("productName", isEqualTo: _searchController.text)
                .snapshots(),
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
                                  height: size.height * 0.9,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: ClipRect(
                                            child: new CachedNetworkImage(
                                              height: 165,
                                              width: 200,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  new LinearProgressIndicator(
                                                backgroundColor: Colors.black,
                                                minHeight: 8,
                                              ),
                                              imageUrl: productSnapshot[index]
                                                  .get('productImages'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$${productSnapshot[index].get('productPrice')}',
                                          style: TextStyle(fontSize: 18),
                                        )
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
            icon: new Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.add_box), label: 'Add Product'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.eco_sharp), label: 'Labels'),
        ],
        onTap: (int item) async {
          switch (item) {
            case 0:
              return Navigator.of(context).pushNamed(Routes.ProfileRoute);
            case 1:
              return Navigator.of(context).pushNamed(Routes.ProductPostRoute);
            case 2:
              return Navigator.of(context).pushNamed(Routes.InfoRoute);
          }
        },
      ),
      body: new Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
          Expanded(child: products),
        ],
      ),
    );
  }
}
