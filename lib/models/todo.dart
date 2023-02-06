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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'note': note,
      'date': date.toIso8601String(),
      'isdone': isDone.toString(),
    };
  }

  void changeCheck() {
    isDone = !isDone;
    notifyListeners();
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, title: $title, type: $type, note: $note, date: $date, isdone: $isDone}';
  }
}
