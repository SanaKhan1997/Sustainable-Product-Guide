import 'package:flutter/cupertino.dart';

import 'Label.dart';

class Product {
  final String productType;
  final String productName;
  final String productCompany;
  final String productDescription;
  final String productPrice;
  final String productId;
  final String productImages;
  final List<dynamic> productLabels;

  Product(
      {@required this.productType,
      @required this.productName,
      @required this.productCompany,
      @required this.productDescription,
      @required this.productPrice,
      @required this.productImages,
      @required this.productLabels,
      @required this.productId});

  Product.fromJSON(Map<String, dynamic> json, String _productId)
      : productType = json['productType'],
        productName = json['productName'],
        productCompany = json['productCompany'],
        productDescription = json['productDescription'],
        productPrice = json['productPrice'],
        productImages = json['productImages'],
        productLabels = json['productLabels'],
        productId = _productId;

  Map<String, dynamic> toJSON() => {
        'productType': productType,
        'productName': productName,
        'productCompany': productCompany,
        'productDescription': productDescription,
        'productPrice': productPrice,
        'productImages': productImages,
        'productLabels': productLabels,
      };
}
