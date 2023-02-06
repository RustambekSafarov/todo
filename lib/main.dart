import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/db_saver.dart';
import 'package:todo/provider/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/categories_screen.dart';
import 'package:todo/screens/splash_screen.dart';
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
          create: (context) => DBSaver(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash',
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          TodoListScreen.routeName: (context) => const TodoListScreen(),
          CategoryScreen.routeName: (context) => const CategoryScreen(),
          AddTodoScreen.routeName: (context) => const AddTodoScreen(),
        },
      ),
    );
  }
}
