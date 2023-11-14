import 'package:flutter/material.dart' show Color;

class Course {
  final String title;
  final String description;
  final String icon;
  final Color color;

  Course({
    required this.title,
    this.description = 'Build and animate an iOS app from scratch',
    this.icon = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<Course> courses = [
  Course(
    title: "Animations in SwiftUI",
  ),
  Course(
    title: "Animations in Flutter",
    icon: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(title: "State Machine"),
  Course(
    title: "Animated Menu",
    color: const Color(0xFF9CC5FF),
    icon: "assets/icons/code.svg",
  ),
  Course(title: "Flutter with Rive"),
  Course(
    title: "Animated Menu",
    color: const Color(0xFF9CC5FF),
    icon: "assets/icons/code.svg",
  ),
];
