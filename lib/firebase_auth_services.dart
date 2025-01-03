import 'package:firebase_auth/firebase_auth.dart';


class FireBaseAuthService {
    FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e) {
      print("some error occured $e");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e) {
      print("some error occured: $e");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out");
    } catch(e) {
      print("some error occured: $e");
    }
  }
}