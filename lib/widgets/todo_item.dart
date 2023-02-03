import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';

import '../models/db_saver.dart';

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

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    // final isChecked = Provider.of<Todo>(context);
    return Consumer<Todo>(
      builder: (context, value, child) => ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: Checkbox(
          value: widget.isDone,
          onChanged: (val) {
            value.changeCheck();
          },
        ),
      ),
    );
  }
}
