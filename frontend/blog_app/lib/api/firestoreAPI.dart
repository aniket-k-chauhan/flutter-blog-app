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

Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
  return usersCollection.snapshots();
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

Future<UserModel> getUserDetailsByEmail(String email) async {
  try {
    final userDetails =
        await usersCollection.where("email", isEqualTo: email).get();
    final user = UserModel.fromJson(userDetails.docs[0].data());
    return user;
  } on FirebaseException catch (error) {
    throw Exception(error.message ?? "Internal Server Error");
  } catch (error) {
    throw Exception("Internal Server Error");
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
    throw Exception(error.message ?? "User not added successfully");
  } catch (error) {
    throw Exception("Something Went Wrong while adding user");
  }
}
