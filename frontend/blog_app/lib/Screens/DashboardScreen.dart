import 'package:flutter/material.dart';

import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/views/blog/blog.dart';
import 'package:blog_app/views/contact/contact.dart';
import 'package:blog_app/views/portfolio/portfolio.dart';
import 'package:blog_app/widgets/blog/blog_floating_action_button.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/portfolio/portfolio_floating_action_button.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<String> title = ["Portfolios", "Blogs", "Contact"];
  final List<Widget> body = [Portfolio(), Blog(), Contact()];
  final List<Widget> floatingActionButton = [
    PortfolioFloatingActionButton(),
    BlogFloatingActionButton()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 198, 229, 255),
        title: Text(
          title[_selectedIndex],
          style: TextStyle(
            fontSize: 28,
            color: Color.fromARGB(223, 41, 88, 127),
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            color: Color.fromARGB(223, 41, 88, 127),
            onPressed: () async {
              try {
                await Auth.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonSnackBar.buildSnackBar(
                        context, "Successfully Logged out", "success"));
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonSnackBar.buildSnackBar(
                        context, error.toString(), "error"));
              }
            },
            iconSize: 34,
            icon: const Row(
              children: [
                Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(223, 41, 88, 127),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.logout_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
      body: body[_selectedIndex],
      floatingActionButton:
          _selectedIndex == 2 ? null : floatingActionButton[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(223, 41, 88, 127),
        currentIndex: _selectedIndex,
        iconSize: 34,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Portfolio",
            icon: Icon(
              Icons.dashboard,
            ),
          ),
          BottomNavigationBarItem(
            label: "Blog",
            icon: Icon(
              Icons.newspaper_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Contact",
            icon: Icon(
              Icons.contact_mail_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
