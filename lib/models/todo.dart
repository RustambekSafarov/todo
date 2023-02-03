import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  String title;
  String id;
  String type;
  String note;
  DateTime date;
  bool isDone;

  Todo({
    required this.title,
    required this.id,
    required this.type,
    required this.note,
    required this.date,
    this.isDone = false,
  });

  void changeCheck() {
    isDone = !isDone;
    notifyListeners();
  }
}
