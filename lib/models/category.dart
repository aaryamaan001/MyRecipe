import 'package:flutter/material.dart';

class Category {
  //constructory needed to initialize the values
  const Category(
      {required this.id, required this.title, this.color = Colors.orange});
  final String id; //String wagera dart me h...import
  final String title;
  final Color color;
}
