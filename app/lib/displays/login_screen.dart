import 'package:app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  final loginKey = GlobalKey<FormState>();

  LoginScreen({
    Key key,
  }) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                                "Login",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: size.height * 0.04),
                              TextField(
                                controller: _emailController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Email'),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextField(
                                controller: _pwdController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    labelText: 'Password'),
                              ),
                              SizedBox(height: size.height * 0.02),
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
                                        _emailController.text.isNotEmpty &&
                                                _pwdController.text.isNotEmpty
                                            ? loginUser()
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.value.text.trim(),
            password: _pwdController.value.text.trim())
        .then((_) => Navigator.of(context).pushNamed(Routes.HomeRoute));
  }
}
