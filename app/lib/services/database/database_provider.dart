import 'package:app/data_models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseProvider();

  Future<void> setNewUser(Users user) async =>
      _firestore.collection('users').doc(user.userId).set(user.toJSON());
}
