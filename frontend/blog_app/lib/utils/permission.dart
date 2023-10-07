import 'package:blog_app/auth/auth.dart';

// check for write access of user
bool hasWriteAccess(String email) {
  String currentUserEmail = Auth.getLoggedInUser()!.email!;

  return email == currentUserEmail ? true : false;
}
