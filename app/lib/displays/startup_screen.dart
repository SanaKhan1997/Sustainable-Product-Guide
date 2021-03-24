import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../routes.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#3c5949"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 45,
                width: 150,
                child: RaisedButton(
                    color: HexColor("#F5F5F5").withOpacity(0.4),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.LoginRoute);
                    })),
            const SizedBox(height: 35),
            const Text(
              "Don't have an account?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 15),
            SizedBox(
                height: 45,
                width: 150,
                child: RaisedButton(
                    color: HexColor("#F5F5F5").withOpacity(0.4),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.SignupRoute);
                    })),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
