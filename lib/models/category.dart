import 'package:flutter/material.dart';

class iCategory {
  const iCategory({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
