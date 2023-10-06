import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/portfolio/portfolio_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                final List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                    snapshot.data!.docs;
                final String currentUserEmail = Auth.getLoggedInUser()!.email!;
                final QueryDocumentSnapshot<Map<String, dynamic>> currentUser =
                    users.firstWhere(
                        (user) => user["email"] == currentUserEmail);

                users.removeWhere((user) => user["email"] == currentUserEmail);

                users.insert(0, currentUser);

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? user = users[index].data();
                    return PortfolioCard(
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
                    CommonSnackBar.buildSnackBar(context, error.toString()));
              }
            }
            return Center(
              child: CustomLoader(),
            );
          }),
    );
  }
}
