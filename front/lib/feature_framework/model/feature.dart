import 'package:flutter/material.dart';

class Feature {
  final String name;
  final String iconPath;
  final WidgetBuilder mainScreenBuilder;

  const Feature({
    required this.name,
    required this.iconPath,
    required this.mainScreenBuilder,
  });
}
