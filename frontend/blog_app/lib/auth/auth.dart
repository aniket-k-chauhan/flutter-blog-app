import "package:firebase_auth/firebase_auth.dart";

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseException catch (error) {
      throw Exception(error.message ?? "Something went wrong");
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }

  static Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (error) {
      throw Exception(error.message ?? "Something went wrong");
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }

  static Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseException catch (error) {
      throw Exception(error.message ?? "Something went wrong");
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }

  static User? getLoggedInUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseException catch (error) {
      throw Exception(error.message ?? "Something went wrong");
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }
}
