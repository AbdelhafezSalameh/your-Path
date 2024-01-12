import 'package:flutter/material.dart';

enum TaskCategory {
  education(Icons.school, Colors.white),
  health(Icons.favorite, Colors.white),
  home(Icons.home, Colors.white),
  others(Icons.calendar_month_rounded, Colors.white),
  personal(Icons.person, Colors.white),
  shopping(Icons.shopping_bag, Colors.white),
  social(Icons.people, Colors.white),
  travel(Icons.flight, Colors.white),
  work(Icons.work, Colors.white);

  static TaskCategory stringToTaskCategory(String name) {
    try {
      return TaskCategory.values.firstWhere(
        (category) => category.name == name,
      );
    } catch (e) {
      return TaskCategory.others;
    }
  }

  final IconData icon;
  final Color color;
  const TaskCategory(this.icon, this.color);
}
