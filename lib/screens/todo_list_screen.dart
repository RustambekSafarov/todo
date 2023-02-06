import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/db_saver.dart';

import '../widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});
  static const routeName = '/todo-list';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];

    return Scaffold(
      body: Consumer<DBSaver>(
        builder: (context, value, child) => CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(categoryTitle!),
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
                (context, index) => ChangeNotifierProvider.value(
                  value: value,
                  child: Dismissible(
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await value
                                      .deleteTodo(value.todoList[index].id);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: TodoItem(
                      isDone: value.todoList[index].isDone,
                      title: value.todoList[index].title,
                      description: value.todoList[index].date.toIso8601String(),
                    ),
                  ),
                ),
                childCount: value.todoList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
