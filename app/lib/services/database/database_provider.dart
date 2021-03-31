import 'dart:io';

import 'package:app/data_models/product.dart';
import 'package:app/data_models/reviews.dart';
import 'package:app/data_models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class DatabaseProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  DatabaseProvider();

  Future<void> setNewUser(Users user) async =>
      _firestore.collection('users').doc(user.userId).set(user.toJSON());

  Future<void> setNewProduct(Product product) async =>
      _firestore.collection('products').add(product.toJSON());

  Future<Users> getUser(String userId) async => _firestore
      .collection('users')
      .doc(userId)
      .get()
      .then((DocumentSnapshot snapshot) =>
          Users.fromJSON(snapshot.data(), snapshot.id));

  Future<void> updateUser(Users user) =>
      _firestore.collection('users').doc(user.userId).update(user.toJSON());

  Stream<List<Product>> getProducts() =>
      _firestore.collection('products').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJSON(doc.data(), doc.id)));

  Future<void> addReview(Review review) async =>
      _firestore.collection('reviews').add(review.toJSON());

  Future<String> uploadProductImage(File image, String fileName) async =>
      _storage
          .ref()
          .child('productImages/$fileName')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL())
          .timeout(Duration(seconds: 10),
              onTimeout: () => Future.error(PlatformException(
                  message: "Connection timed out!", code: "FUTURE_TIMEOUT")));

  Future<String> uploadUserImage(File image, String fileName) async => _storage
      .ref()
      .child('userImages/$fileName')
      .putFile(image)
      .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL())
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: 'Connection timed out!', code: 'FUTURE_TIMEOUT')));
}
