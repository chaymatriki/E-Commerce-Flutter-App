import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  //collection reference
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection("users");

  //set user data
  Future setUserData(String email, String password, String firstName,
      String lastName, String phoneNumber, String address) async {
    return await usersCollection.doc(uid).set({
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
    });
  }

  //update user data
  Future updateUserData(Map<String, Object> userData) async {
    print('hello from updatefct');
    print(userData);
    return await usersCollection.doc(uid).update(userData);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        snapshot.data()['email'],
        snapshot.data()['password'],
        snapshot.data()['firstName'],
        snapshot.data()['lastName'],
        snapshot.data()['phoneNumber'],
        snapshot.data()['address']);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
