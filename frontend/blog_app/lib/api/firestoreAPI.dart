import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:blog_app/model/contact.dart';
import 'package:blog_app/model/user.dart';

final db = FirebaseFirestore.instance;

final usersCollection = db.collection("users");
final contactUsCollection = db.collection("contactUs");

Future<void> addUser(UserModel user) async {
  try {
    await usersCollection.add(user.toJson());
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "User not added successfully");
  } catch (error) {
    throw Exception("Something Went Wrong while adding user");
  }
}

Future getAllUsers() async {
  try {
    usersCollection.snapshots();
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "Contact details not added successfully");
  } catch (error) {
    throw Exception("Something Went Wrong while adding contact details");
  }
}

Future<void> addCotactUsDetails(ContactModel contactDetails) async {
  try {
    await contactUsCollection.add(contactDetails.toJson());
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "Contact details not added successfully");
  } catch (error) {
    throw Exception("Something Went Wrong while adding contact details");
  }
}
