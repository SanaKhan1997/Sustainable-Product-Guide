import 'package:app/data_models/product.dart';
import 'package:app/data_models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseProvider();

  Future<void> setNewUser(Users user) async =>
      _firestore.collection('users').doc(user.userId).set(user.toJSON());

  Future<void> setNewProduct(Product product) async =>
      _firestore.collection('products').add(product.toJSON());

  Future<Users> getUser(String userId) async => _firestore
      .collection('users')
      .doc(userId)
      .get()
      .then((DocumentSnapshot snapshot) => Users.fromJSON(snapshot.data()));

  Future<void> updateUser(Users user) =>
      _firestore.collection('users').doc(user.userId).update(user.toJSON());

  Stream<List<Product>> getProducts() =>
      _firestore.collection('products').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJSON(doc.data(), doc.id)));
}
