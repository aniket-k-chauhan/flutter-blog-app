import 'package:blog_app/widgets/portfolio/common_chip.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/views/portfolio/portfolio_details.dart';

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
