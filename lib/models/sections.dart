import 'package:flutter/material.dart';

class Section with ChangeNotifier {
  final int id;
  final String title;
  final Icon icon;
  final int tasks;
  final String type;

  Section({
    required this.id,
    required this.title,
    required this.icon,
    required this.tasks,
    required this.type,
  });
}
