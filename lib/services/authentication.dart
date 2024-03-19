import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String?> signIn(String email, String password);

  Future<void> deleteUser();

  Future<String?> reauthenticate(String email, String password);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> deleteUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      await user?.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> reauthenticate(String email, String password) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);

        await user.reauthenticateWithCredential(credential);
        return user.uid;
      } else {
        throw Exception('User not signed in.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
