import 'package:correct_speech/infrastructure/app.dart';
import 'package:correct_speech/infrastructure/injection.dart';
import 'package:flutter/material.dart';

void main() async {
  await injectDependencies();
  runApp(const App(body: null));
}
