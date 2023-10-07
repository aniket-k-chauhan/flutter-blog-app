import 'package:blog_app/widgets/portfolio/common_chip.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/views/portfolio/portfolio_details.dart';

class PortfolioCard extends StatelessWidget {
  final int index;
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
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: index == 0
          ? Color.fromARGB(223, 41, 88, 127)
          : Color.fromARGB(117, 91, 154, 206), // main Color
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).pushNamed("/portfolio",
              arguments: PortfolioDetailsArgumets(email, isReadOnly: true));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(199, 198, 229, 255),
                radius: 32,
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(223, 41, 88, 127),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: index == 0
                          ? Color.fromARGB(199, 198, 229, 255)
                          : Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
