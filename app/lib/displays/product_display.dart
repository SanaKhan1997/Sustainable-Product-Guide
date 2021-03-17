import 'package:app/data_models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  ProductScreen({this.product});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(product.productName),
          backgroundColor: HexColor("#3c5949"),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    imageUrl: product.productImages,
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(color: HexColor("#3c2221")),
                  child: Text(
                    product.productName,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    "Product Company: ${product.productCompany}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    "Product Price: ${product.productPrice}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
