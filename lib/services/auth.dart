import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/models/user.dart';
import 'package:shop_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //register
  Future<UserCredential> registerUser(email, password, String firstName,
      String lastName, String phoneNumber, String address) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: userCredential.user.uid).setUserData(
          email, password, firstName, lastName, phoneNumber, address);
    } catch (e) {
      print(e.toString());
    }
    return userCredential;
  }

  //sign in
  Future<UserCredential> signInUser(email, password) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
    return userCredential;
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
