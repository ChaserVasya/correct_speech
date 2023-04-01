import 'package:flutter/material.dart';

class Feature {
  final String name;
  final String iconPath;
  final Map<String, WidgetBuilder> routes;

  const Feature({
    required this.name,
    required this.iconPath,
    required this.routes,
  });
}
