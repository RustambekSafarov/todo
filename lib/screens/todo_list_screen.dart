import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  String title;
  String type;
  TodoListScreen({super.key, required this.title, required this.type});
  static const routeName = 'todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/todo-back.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: value.todos(),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Dismissible(
                key: ValueKey(index),
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          'Really, Do you want to delete this todo?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {},
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: TodoItem(
                  isDone: false,
                  title: '',
                  description: '',
                ),
              ),
              childCount: 0,
            ),
          ),
        ],
      ),
    );
  }
}
