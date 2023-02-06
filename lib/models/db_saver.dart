import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'todo.dart';

class DBSaver with ChangeNotifier {
  // Database? database;
  Future<Database> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), 'tod.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todo(id TEXT PRIMARY KEY, title TEXT, type TEXT, note TEXT, date TEXT, isdone TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await openDB();

    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  List<Todo> _todoList = [];

  Future<void> getTodos() async {
    final db = await openDB();

    final List<Map<String, dynamic>> maps = await db.query('todo');

    _todoList = List.generate(maps.length, (index) {
      return Todo(
        title: maps[index]['title'],
        id: maps[index]['id'],
        type: maps[index]['type'],
        note: maps[index]['note'],
        date: DateTime.parse(maps[index]['date']),
        isDone: maps[index]['isdone'],
      );
    });
    db.close();
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await openDB();

    db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
    db.close();
  }

  Future<void> deleteTodo(String id) async {
    final db = await openDB();

    db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );

    db.close();
  }

  List<Todo> get todoList {
    return [..._todoList];
  }
}
