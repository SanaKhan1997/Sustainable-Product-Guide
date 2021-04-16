import 'package:app/data_models/product.dart';
import 'package:app/data_models/reviews.dart';
import 'package:app/data_models/user.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  final TextEditingController _commentController = TextEditingController();
  final databaseService = DatabaseProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProductScreen({this.product});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget commentWidget = new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reviews')
            .where('productId', isEqualTo: product.productId)
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

              var commentCount = 0;
              List<DocumentSnapshot> commentSnapshot;

              if (snapshot.hasData) {
                commentSnapshot = snapshot.data.docs;
                commentCount = commentSnapshot.length;

                if (commentCount > 0) {
                  return new Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ExpansionTile(
                        leading: Icon(Icons.comment, color: Colors.black),
                        trailing: Text(commentCount.toString()),
                        title: Text("Reviews",
                            style: TextStyle(color: Colors.black)),
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: commentCount,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Card(
                                    color: HexColor('99CC99'),
                                    child: Container(
                                      height: size.height * 0.09,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Posted By: ${commentSnapshot[index].get('ownerName')}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: size.width * 0.95,
                                            height: size.height * 0.05,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                                commentSnapshot[index]
                                                    .get('comment'),
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
                      'No comments found',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            case ConnectionState.done:
              return new Text('Streaming is done');
          }
          return Container(
            constraints: BoxConstraints(maxHeight: 5),
            child: new Text('No comments found'),
          );
        });
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(product.productName),
          backgroundColor: HexColor("#3c5949"),
        ),
        body: SingleChildScrollView(
          child: Container(
              color: HexColor("#E4DBDB"),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(
                          value: 15,
                        ),
                        imageUrl: product.productImages,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(color: HexColor("#3c5949")),
                      child: Text(
                        product.productName,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        width: size.width,
                        color: HexColor('#E4DBDB'),
                        child: SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: product.productLabels.length,
                              itemBuilder: (context, int index) {
                                return Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                      color: HexColor('99CC99'),
                                      child: Text(
                                        product.productLabels[index],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                              },
                            ))),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.productCompany,
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                "\$${product.productPrice}",
                                style: TextStyle(fontSize: 22),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "Product Type: ${product.productType}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "Product Description: ${product.productDescription}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(color: HexColor("#3c5949")),
                      child: Text(
                        "Reviews",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(fontStyle: FontStyle.italic),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: 'Write your review here...'),
                      ),
                    ),
                    SizedBox(
                        height: 45,
                        width: 180,
                        child: RaisedButton(
                            color: HexColor("#3c5949"),
                            child: Text(
                              'Comment',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            onPressed: () async {
                              _commentController.text.isNotEmpty
                                  ? postProduct(context)
                                  : showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text("Error"),
                                          content: Text("Cannot post comment"),
                                        );
                                      });
                            })),
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        width: size.width,
                        decoration: BoxDecoration(color: Colors.white),
                        child: commentWidget),
                  ],
                ),
              )),
        ));
  }

  Future<Users> getUserName() async => FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser.uid)
      .get()
      .then((DocumentSnapshot snapshot) =>
          Users.fromJSON(snapshot.data(), snapshot.id));

  postProduct(BuildContext context) async {
    Users commentOwner = await getUserName();
    await databaseService.addReview(Review(
        comment: _commentController.text,
        datePosted: DateTime.now().toString(),
        productId: product.productId,
        ownerId: _auth.currentUser.uid,
        ownerName: commentOwner.firstName));
  }
}
