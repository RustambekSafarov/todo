import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/screens/login_screen.dart';

class MainDrawer extends StatelessWidget {
  String username;
  MainDrawer({super.key, required this.username});
  double radius = 45;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Drawer(
        width: width - width / 5,
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 3,
              color: Colors.indigo[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    radius: radius,
                    child: Icon(
                      Icons.person,
                      size: radius + 2,
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    trailing: Icon(Icons.login),
                    title: Text('Login'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.login),
                    title: Text('Log out'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
