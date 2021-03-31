import 'dart:io';

import 'package:app/data_models/user.dart';
import 'package:app/routes.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignUpScreen extends StatefulWidget {
  final signupKey = GlobalKey<FormState>();

  SignUpScreen({
    Key key,
  }) : super(key: key);

  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final databaseService = DatabaseProvider();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
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
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 30,
                        )),
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
                                      borderRadius: BorderRadius.circular(50),
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
                                        Icons.add_photo_alternate_rounded,
                                        color: Colors.grey[800],
                                        size: 50,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 30,
                        )),
                        TextFormField(
                          key: ObjectKey("First Name"),
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              labelText: 'First Name'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 20,
                        )),
                        TextFormField(
                          key: ObjectKey("Last Name"),
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              labelText: 'Last Name'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 20,
                        )),
                        TextFormField(
                          key: ObjectKey("Email Address"),
                          controller: _emailController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              labelText: 'Email Address'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 20,
                        )),
                        TextField(
                          key: ObjectKey("Password"),
                          controller: _pwdController,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              labelText: 'Password'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 20,
                        )),
                        SizedBox(
                            height: 42,
                            width: 170,
                            child: RaisedButton(
                                color: HexColor("#3C5949").withOpacity(0.4),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                onPressed: () {
                                  _firstNameController.text.isNotEmpty &&
                                          _lastNameController.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _pwdController.text.isNotEmpty
                                      ? signupUser(context)
                                      : showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content:
                                                  Text("Registration Error"),
                                            );
                                          });
                                })),
                        Padding(
                            padding: EdgeInsets.only(
                          top: 20,
                        )),
                        SizedBox(
                            height: 42,
                            width: 170,
                            child: RaisedButton(
                                color: HexColor("#3C5949").withOpacity(0.4),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<String> getImagePath(File image) async =>
      databaseService.uploadUserImage(imageFile, basename(imageFile.path));

  //TODO add database service
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signupUser(BuildContext context) async {
    String userImageUrl = await getImagePath(imageFile);
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _pwdController.text.trim())
        .then((authUser) {
      databaseService
          .setNewUser(Users(
              userId: authUser.user.uid,
              firstName: _firstNameController.value.text,
              lastName: _lastNameController.value.text,
              email: _emailController.value.text.trim(),
              userImage: userImageUrl))
          .then((_) => Navigator.of(context).pushNamed(Routes.LoginRoute));
    });
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
