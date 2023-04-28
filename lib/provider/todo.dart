import 'package:flutter/material.dart';

import '../models/sections.dart';

class CategoryList with ChangeNotifier {
  final List<Section> _categories = [
    Section(
      id: 0,
      title: 'All',
      icon: const Icon(
        Icons.assignment,
        color: Color(0xFF5786FF),
        size: 30,
      ),
      tasks: 0,
      type: 'all',
    ),
    Section(
        id: 1,
        title: 'Work',
        icon: const Icon(
          Icons.work,
          color: Color(0xFFFDBF80),
          size: 30,
        ),
        tasks: 0,
        type: 'work'),
    Section(
        id: 2,
        title: 'Music',
        icon: const Icon(
          Icons.library_music,
          color: Color(0xFFF89885),
          size: 30,
        ),
        tasks: 0,
        type: 'music'),
    Section(
        id: 3,
        title: 'Travel',
        icon: const Icon(
          Icons.travel_explore,
          color: Color(0xFF6AD18A),
          size: 30,
        ),
        tasks: 0,
        type: 'travel'),
    Section(
        id: 4,
        title: 'Study',
        icon: const Icon(
          Icons.menu_book_sharp,
          color: Color(0xFFB6B1E1),
          size: 30,
        ),
        tasks: 0,
        type: 'study'),
    Section(
        id: 5,
        title: 'Home',
        icon: const Icon(
          Icons.home_sharp,
          color: Color(0xFFF89885),
          size: 30,
        ),
        tasks: 0,
        type: 'home'),
  ];
  List<Section> get categories {
    return [..._categories];
  }

  String token = '';

  updateToken(String token1) {
    token = token1;
    notifyListeners();
  }
}
