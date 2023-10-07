import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/portfolio/portfolio_card.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: StreamBuilder(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                // Extract the users from firebase
                final List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                    snapshot.data!.docs;

                final String currentUserEmail = Auth.getLoggedInUser()!.email!;

                // Extract current user details from fetched users list
                final QueryDocumentSnapshot<Map<String, dynamic>> currentUser =
                    users.firstWhere(
                        (user) => user["email"] == currentUserEmail);

                // Remove current user from the list
                users.removeWhere((user) => user["email"] == currentUserEmail);

                // Insert current user at first position
                users.insert(0, currentUser);

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? user = users[index].data();
                    return PortfolioCard(
                      index: index,
                      name: user["name"],
                      email: user["email"],
                      skills: user["skills"],
                      projects: user["projects"],
                      achievements: user["achievements"],
                    );
                  },
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonSnackBar.buildSnackBar(
                        context, error.toString(), "error"));
              }
            }
            return Center(
              child: CustomLoader(),
            );
          }),
    );
  }
}
