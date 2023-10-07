/// contains all method ralated to operation with firestore database

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
    throw Exception(error.message ?? "User Details not added successfully");
  } catch (error) {
    throw Exception("Something went wrong while adding user details");
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
  return usersCollection.snapshots();
}

Future<UserModel> getUserDetailsByEmail(String email) async {
  try {
    final userDetails =
        await usersCollection.where("email", isEqualTo: email).get();
    final user = UserModel.fromJson(userDetails.docs[0].data());
    return user;
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "Can't able to fetch User details");
  } catch (error) {
    throw Exception("can't able to fetch User details");
  }
}

Future<void> updateUser(UserModel user, String email) async {
  try {
    final QuerySnapshot querySnapshot =
        await usersCollection.where("email", isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.length == 1) {
      querySnapshot.docs.forEach((doc) async {
        // Update the document
        await usersCollection.doc(doc.id).update(user.toJson());
      });
    }
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "Details Not Updated successfully");
  } catch (error) {
    throw Exception("Something went wrong while updating your details");
  }
}

Future<void> addCotactUsDetails(ContactModel contactDetails) async {
  try {
    await contactUsCollection.add(contactDetails.toJson());
  } on FirebaseException catch (error) {
    throw Exception(
        error.message ?? "Contact details not submitted successfully");
  } catch (error) {
    throw Exception("Something Went Wrong while submitting contact details");
  }
}
