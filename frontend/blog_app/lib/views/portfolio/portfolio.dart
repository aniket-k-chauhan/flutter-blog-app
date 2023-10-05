import 'dart:developer';

import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/views/portfolio/portfolio_details.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
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
            return !snapshot.hasData
                ? Center(
                    child: CustomLoader(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? user =
                          snapshot.data!.docs[index].data();
                      return PortfolioCard(
                        name: user["name"],
                        email: user["email"],
                        skills: user["skills"],
                        projects: user["projects"],
                        achievements: user["achievements"],
                      );
                    },
                  );
          }),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  final String name;
  final String email;
  final List<dynamic>? skills;
  final List<dynamic>? projects;
  final List<dynamic>? achievements;

  const PortfolioCard({
    super.key,
    required this.name,
    required this.email,
    this.skills,
    this.projects,
    this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/portfolio",
            arguments: PortfolioDetailsArgumets(email, isReadOnly: true));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4),
        color: Color.fromARGB(117, 91, 154, 206),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17, letterSpacing: 0.2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 6,
                        children: [
                          CommonChip(
                            labelText: "Projects: ${projects?.length ?? 0}",
                          ),
                          CommonChip(
                            labelText: "Skills: ${skills?.length ?? 0}",
                          ),
                          CommonChip(
                            labelText:
                                "Achievements: ${achievements?.length ?? 0}",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonChip extends StatelessWidget {
  const CommonChip({
    super.key,
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(labelText),
      labelStyle: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
