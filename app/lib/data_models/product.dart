import 'package:flutter/cupertino.dart';

class Product {
  final String productId;
  final String productType;
  final String productName;
  final String productCompany;
  final String productDescription;
  final String productPrice;
  final String productImages;

  Product(
      {@required this.productId,
      @required this.productType,
      @required this.productName,
      @required this.productCompany,
      @required this.productDescription,
      @required this.productPrice,
      @required this.productImages});

  Product.fromJSON(Map<String, dynamic> json, String _productId)
      : productId = _productId,
        productType = json['productType'],
        productName = json['productName'],
        productCompany = json['productCompany'],
        productDescription = json['productDescription'],
        productPrice = json['productPrice'],
        productImages = json['productImages'];

  Map<String, dynamic> toJSON() => {
        'productType': productType,
        'productName': productName,
        'productCompany': productCompany,
        'productDescription': productDescription,
        'productImages': productImages,
      };
}
