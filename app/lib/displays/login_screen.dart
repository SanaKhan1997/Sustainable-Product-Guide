import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#698C72'),
      body: Center(
          child: Container(
        width: size.width * 0.8,
        child: SingleChildScrollView(
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
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)),
                    labelText: 'Email'),
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)),
                    labelText: 'Password'),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                  height: 45,
                  width: 180,
                  child: RaisedButton(
                      color: HexColor("#3C5949").withOpacity(0.4),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      onPressed: () {})),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                  height: 42,
                  width: 170,
                  child: RaisedButton(
                      color: HexColor("#3C5949").withOpacity(0.4),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }
}
