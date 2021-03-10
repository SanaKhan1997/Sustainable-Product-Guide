import 'package:flutter/cupertino.dart';

class Users {
  final String firstName;
  final String lastName;
  final String email;

  final String userId;

  Users(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.userId});

  Users.fromJSON(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        userId = json['userId'];

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userId': userId,
      };
}
