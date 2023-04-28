import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/todo.dart';
import '/screens/register_screen.dart';
import '/screens/todo_list_screen.dart';
import '/services/post.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const routeName = 'login-screen';
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token = '';
  String errorMessage = '';
  int? userID;
  bool isvisible = true;
  bool _showUsernameError = false;
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: null,
                  // () {
                  //   context.goNamed(TodoListScreen.routeName);
                  // },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                            // color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please, enter your username!';
                              } else if (errorMessage == 'Error') {
                                return 'Incorrect username or password';
                              }
                              return null;
                            },
                            controller: usernameController,
                            decoration: InputDecoration(
                              errorText: _showUsernameError ? 'Incorrect username' : null,
                              border: OutlineInputBorder(),
                              hintText: "Username*",
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
                              } else if (errorMessage == 'Error') {
                                return 'Incorrect username or password';
                              }
                              return null;
                            },
                            obscureText: isvisible,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: isvisible == true
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
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
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              _formKey.currentState!.validate();

                              userLogin(
                                usernameController.text,
                                passwordController.text,
                              ).then((v) async {
                                if (v != 'Error') {
                                  Provider.of<CategoryList>(context, listen: false).updateToken(v);
                                  context.goNamed(TodoListScreen.routeName, extra: usernameController.text);
                                } else if (v == 'Error') {
                                  setState(() {
                                    errorMessage = 'Error';
                                  });
                                  _formKey.currentState!.validate();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: const Color(0xFF31274F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text('Login'),
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
                            context.goNamed(RegisterScreen.routeName);
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
