import 'dart:io';

import 'package:app/data_models/product.dart';
import 'package:app/data_models/user.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../routes.dart';

class ProductFormScreen extends StatefulWidget {
  final productKey = GlobalKey<FormState>();

  ProductFormScreen({
    Key key,
  }) : super(key: key);

  _ProductFormScreen createState() => _ProductFormScreen();
}

class _ProductFormScreen extends State<ProductFormScreen> {
  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productCompanyController =
      TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#698C72'),
      body: Center(
          child: Container(
              width: size.width * 0.8,
              child: SingleChildScrollView(
                  child: Form(
                      key: widget.key,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Add New Product",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: size.height * 0.04),
                              RawMaterialButton(
                                fillColor: Theme.of(context).buttonColor,
                                child: Icon(Icons.photo),
                                hoverColor: Colors.grey,
                                padding: EdgeInsets.all(10),
                                shape: CircleBorder(),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.ImageRoute);
                                },
                              ),
                              TextField(
                                controller: _productTitleController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Product Name/Title'),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _productCompanyController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Brand Name'),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _productTypeController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Product Type'),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _productPriceController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Product Price'),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _productDescriptionController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Product Description'),
                              ),
                              SizedBox(height: size.height * 0.04),
                              SizedBox(
                                  height: 45,
                                  width: 180,
                                  child: RaisedButton(
                                      color:
                                          HexColor("#3C5949").withOpacity(0.4),
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      onPressed: () async {
                                        _productTitleController
                                                    .text.isNotEmpty &&
                                                _productCompanyController
                                                    .text.isNotEmpty &&
                                                _productDescriptionController
                                                    .text.isNotEmpty &&
                                                _productPriceController
                                                    .text.isNotEmpty &&
                                                _productTypeController
                                                    .text.isNotEmpty
                                            ? postProduct()
                                            : showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    title: Text("Error"),
                                                    content:
                                                        Text("Cannot Login"),
                                                  );
                                                });
                                      })),
                              SizedBox(height: size.height * 0.02),
                              SizedBox(
                                  height: 42,
                                  width: 170,
                                  child: RaisedButton(
                                      color:
                                          HexColor("#3C5949").withOpacity(0.4),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })),
                            ],
                          ),
                        ),
                      ))))),
    );
  }

  postProduct() async {
    final databaseService = DatabaseProvider();
    await databaseService
        .setNewProduct(Product(
            productCompany: _productCompanyController.text,
            productDescription: _productDescriptionController.text,
            productName: _productTitleController.text,
            productPrice: _productPriceController.text,
            productImages:
                'https://firebasestorage.googleapis.com/v0/b/sustainable-product-guide.appspot.com/o/ALOE_SOOTHING_DAY_CREAM_50ML_1_INRSDPS189.jpg?alt=media&token=00af3307-47ba-4f3c-9f0d-d43a77560279',
            productType: _productTypeController.text))
        .then((_) => Navigator.of(context).pushNamed(Routes.HomeRoute));
  }
}
