import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final String? imageUrl;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      color: _getColorFromString(json['color']),
      imageUrl: json['imageUrl'],
    );
  }

  static Color _getColorFromString(String? colorString) {
    switch (colorString?.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'teal':
        return Colors.teal;
      case 'amber':
        return Colors.amber;
      case 'lightblue':
        return Colors.lightBlue;
      case 'lightgreen':
        return Colors.lightGreen;
      default:
        return Colors.orange;
    }
  }
}
