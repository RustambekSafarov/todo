import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/register_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryList(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
                path: '/',
                name: LoginScreen.routeName,
                builder: (context, state) => LoginScreen(),
                routes: [
                  GoRoute(
                      path: 'todo',
                      name: TodoListScreen.routeName,
                      builder: (context, state) => TodoListScreen(),
                      routes: [
                        GoRoute(
                          path: 'add-new',
                          name: AddTodoScreen.routeName,
                          builder: (context, state) => AddTodoScreen(),
                        ),
                      ]),
                  GoRoute(
                    path: 'register',
                    name: RegisterScreen.routeName,
                    builder: (context, state) => RegisterScreen(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
