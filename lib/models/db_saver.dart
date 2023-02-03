import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'todo.dart';

class DBSaver with ChangeNotifier {
  // Database? database;
  Future<Database> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todo(id integer, title TEXT, type TEXT, note TEXT, date DATETIME)');
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await openDB();

    await db.insert(
      'todo',
      {
        'title': todo.title,
        'id': todo.id,
        'type': todo.type,
        'note': todo.note,
        'date': todo.date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  List<Todo> todoList = [];
  Future<void> todos() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('todo');

    todoList = List.generate(maps.length, (index) {
      return Todo(
        title: maps[index]['title'],
        id: maps[index]['id'],
        type: maps[index]['type'],
        note: maps[index]['note'],
        date: maps[index]['date'],
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await openDB();

    db.update(
      'todo',
      {
        'title': todo.title,
        'id': todo.id,
        'type': todo.type,
        'note': todo.note,
        'date': todo.date,
      },
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await openDB();

    db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
