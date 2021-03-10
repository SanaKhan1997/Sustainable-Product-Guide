import 'package:app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SustainableProductGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.StartupRoute,
    );
  }
}
