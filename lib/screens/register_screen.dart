import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';
import 'package:todo/services/post.dart';
import 'package:todo/services/sqflite_db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
  static const routeName = 'register-screen';
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String? token;
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Login",
                  style: TextStyle(
                      color: Color.fromRGBO(49, 39, 79, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[50],
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4BC487C6),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "First name",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Last name",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          obscureText: isvisible,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: isvisible == true
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFC487C6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: height / 15,
                    width: width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        createUser(
                          usernameController.text,
                          passwordController.text,
                          emailController.text,
                          firstNameController.text,
                          lastNameController.text,
                        ).then((value) {
                          token = value;
                          saveTokenToDatabase(token!);
                          context.goNamed(TodoListScreen.routeName,
                              extra: usernameController.text);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF31274F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text('Sign up'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.goNamed(LoginScreen.routeName);
                    },
                    child: const Text(
                      "Already have an account",
                      style: TextStyle(
                        color: Color(0x9931274F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
