import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';
import 'package:todo/services/post.dart';

import '../provider/todo.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
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
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: <Widget>[
                        TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "First name",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Last name",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please, enter your username!';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Username*",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please, enter your password!';
                            }
                            return null;
                          },
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
                            border: const OutlineInputBorder(),
                            hintText: "Password*",
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
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
                            color: Colors.grey,
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
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              createUser(
                                usernameController.text,
                                passwordController.text,
                                emailController.text,
                                firstNameController.text,
                                lastNameController.text,
                              ).then((v) async {
                                Provider.of<CategoryList>(context).updateToken(v);
                                context.goNamed(TodoListScreen.routeName, extra: usernameController.text);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: const Color(0xFF31274F),
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
                            color: Colors.indigo,
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
        ),
      ),
    );
  }
}
