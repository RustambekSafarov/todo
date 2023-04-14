import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/screens/login_screen.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});
  double radius = 45;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Drawer(
      width: 270,
      child: Column(
        children: [
          Container(
            width: width,
            height: height / 4,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('example@gmail.com'),
                    SizedBox(
                      width: width / 10,
                    ),
                    IconButton(
                      onPressed: () {
                        context.goNamed(LoginScreen.routeName);
                      },
                      icon: Icon(Icons.login),
                    ),
                    SizedBox(
                      width: width / 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
