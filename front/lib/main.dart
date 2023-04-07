import 'package:correct_speech/app.dart';
import 'package:correct_speech/inject.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectApp();
  runApp(const App());
}
