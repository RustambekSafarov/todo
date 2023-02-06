import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/db_saver.dart';
import 'package:todo/provider/todo.dart';

import '../widgets/cat_item.dart';
import 'add_todo_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const routeName = '/category-list';

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryList>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Lists',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => CategoryItem(
                    tasks: 0,
                    title: value.categories[index].title,
                    icon: value.categories[index].icon,
                    type: value.categories[index].type,
                  ),
                  itemCount: value.categories.length,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddTodoScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
