import 'dart:io';

import 'package:app/data_models/product.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../routes.dart';

class ProductFormScreen extends StatefulWidget {
  final productKey = GlobalKey<FormState>();

  ProductFormScreen({
    Key key,
  }) : super(key: key);

  _ProductFormScreen createState() => _ProductFormScreen();
}

class _ProductFormScreen extends State<ProductFormScreen> {
  final databaseService = DatabaseProvider();
  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productCompanyController =
      TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  File imageFile;

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
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: imageFile != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              imageFile,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.photo,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _productTitleController,
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
                                                    .text.isNotEmpty &&
                                                imageFile != null
                                            ? postProduct(context)
                                            : showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    title: Text("Error"),
                                                    content: Text(
                                                        "Make sure you have filled out information correctly"),
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

  Future<String> getImagePath(File image) async =>
      databaseService.uploadProductImage(imageFile, basename(imageFile.path));

  postProduct(BuildContext context) async {
    String get = await getImagePath(imageFile);
    await databaseService
        .setNewProduct(Product(
            productCompany: _productCompanyController.text,
            productDescription: _productDescriptionController.text,
            productName: _productTitleController.text,
            productPrice: _productPriceController.text,
            productImages: get,
            productType: _productTypeController.text))
        .then((_) => Navigator.of(context).pushNamed(Routes.HomeRoute));
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    File _imageFile = File(image.path);

    setState(() {
      imageFile = _imageFile;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    File _imageFile = File(image.path);

    setState(() {
      imageFile = _imageFile;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
