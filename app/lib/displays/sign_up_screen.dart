import 'package:app/data_models/user.dart';
import 'package:app/routes.dart';
import 'package:app/services/database/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUpScreen extends StatefulWidget {
  final signupKey = GlobalKey<FormState>();

  SignUpScreen({
    Key key,
  }) : super(key: key);

  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

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
                        TextFormField(
                          key: ObjectKey("First Name"),
                          controller: _firstNameController,
                          obscureText: true,
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
                          obscureText: true,
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
                          obscureText: true,
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
                                      ? signupUser()
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

  //TODO add database service
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signupUser() async {
    final databaseService = DatabaseProvider();
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
              email: _emailController.value.text.trim()))
          .then((_) => Navigator.of(context).pushNamed(Routes.LoginRoute));
    });
  }
}
