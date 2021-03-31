import 'package:flutter/cupertino.dart';

class Review {
  final String ownerId;
  final String ownerName;
  final String datePosted;
  final String productId;
  final String comment;

  Review(
      {@required this.ownerId,
      @required this.comment,
      @required this.productId,
      @required this.ownerName,
      @required this.datePosted});

  Review.fromJSON(Map<String, dynamic> json)
      : ownerId = json['ownerId'],
        productId = json['productId'],
        datePosted = json['datePosted'],
        ownerName = json['ownerName'],
        comment = json['comment'];

  Map<String, dynamic> toJSON() => {
        'ownerId': ownerId,
        'ownerName': ownerName,
        'productId': productId,
        'datePosted': datePosted,
        'comment': comment,
      };
}
