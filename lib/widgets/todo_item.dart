import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final String description;
  bool isDone;

  TodoItem({
    super.key,
    required this.title,
    required this.description,
    this.isDone = false,
  });
  static const routeName = 'todo-list';

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Todo>(
      builder: (context, value, child) => ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: Checkbox(
          value: widget.isDone,
          onChanged: (val) {},
        ),
      ),
    );
  }
}
