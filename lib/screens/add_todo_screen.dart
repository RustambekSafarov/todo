import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/todo_list_screen.dart';
import 'package:todo/services/post.dart';

import '../provider/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  static const routeName = 'add-new';

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<CategoryList>(context, listen: false).token;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 14, left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'New Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const SizedBox(height: 27),
              const Text(
                'What are you planning?',
                style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 18),
                child: TextField(
                  style: const TextStyle(fontSize: 21),
                  maxLines: 6,
                  controller: _titleController,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        createTodo(_titleController.text, token);
                        context.goNamed(TodoListScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
