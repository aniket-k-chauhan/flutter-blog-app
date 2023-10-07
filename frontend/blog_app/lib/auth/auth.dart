/// User authentication

import "package:firebase_auth/firebase_auth.dart";

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseException catch (error) {
      String errorMsg;
      switch (error.code) {
        case "invalid-email":
          errorMsg = "Invalid Mail";
        case "weak-password":
          errorMsg = "Password should be at least 6 characters";
        case "email-already-in-use":
          errorMsg = "The email address is already in use by another account";
        default:
          errorMsg = "Authentication Error";
      }
      throw Exception(errorMsg);
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }

  static Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (error) {
      String errorMsg;
      switch (error.code) {
        case "invalid-email":
          errorMsg = "Invalid Mail";
        case "INVALID_LOGIN_CREDENTIALS":
          errorMsg = "Invalid login credentials";
        default:
          errorMsg = "Authentication Error";
      }
      throw Exception(errorMsg);
    } catch (error) {
      throw Exception("Authentication Error");
    }
  }

  static Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseException catch (error) {
      throw Exception(error.code);
    } catch (error) {
      throw Exception("Authentication Error");
    }
  }

  static User? getLoggedInUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseException catch (error) {
      throw Exception(error.message ?? "Can't get current User");
    } catch (error) {
      throw Exception("Can't get current User");
    }
  }
}
