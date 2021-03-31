import 'package:flutter/cupertino.dart';

class Users {
  final String firstName;
  final String lastName;
  final String email;
  final String userImage;
  final String userId;

  Users(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.userImage,
      @required this.userId});

  Users.fromJSON(Map<String, dynamic> json, String user)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        userImage = json['userImage'],
        userId = user;

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userImage': userImage,
        'userId': userId,
      };
}
