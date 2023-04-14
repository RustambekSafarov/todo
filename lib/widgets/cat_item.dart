import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/todo_list_screen.dart';
import 'package:todo/widgets/todo_item.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final int tasks;
  final Icon icon;
  final String type;

  const CategoryItem({
    super.key,
    required this.title,
    required this.tasks,
    required this.icon,
    required this.type,
  });

  selectCategory(BuildContext ctx) {
    ctx.goNamed(
      TodoListScreen.routeName,
      extra: {
        'title': title,
        'type': type,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        selectCategory(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  icon,
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$tasks tasks',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
