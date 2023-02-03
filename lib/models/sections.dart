import 'package:flutter/material.dart';

class Section with ChangeNotifier {
  final String title;
  final Icon icon;
  final int tasks;
  final String type;

  Section({
    required this.title,
    required this.icon,
    required this.tasks,
    required this.type,
  });
}
