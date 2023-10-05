import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/views/blog/blog.dart';
import 'package:blog_app/views/contact/contact.dart';
import 'package:blog_app/views/portfolio/portfolio.dart';
import 'package:blog_app/widgets/blog/blog_floating_action_button.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/portfolio/portfolio_floating_action_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<String> title = ["Portfolio", "Blog", "Contact"];
  final List<Widget> body = [Portfolio(), Blog(), Contact()];
  final List<Widget> floatingActionButton = [
    PortfolioFloatingActionButton(),
    BlogFloatingActionButton()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[_selectedIndex]),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await Auth.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonSnackBar.buildSnackBar(context, error.toString()));
              }
            },
            iconSize: 34,
            icon: Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: body[_selectedIndex],
      floatingActionButton:
          _selectedIndex == 2 ? null : floatingActionButton[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
