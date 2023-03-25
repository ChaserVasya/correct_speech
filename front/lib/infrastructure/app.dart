import 'package:correct_speech/framework/presentation/main_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Widget body;

  const App({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => const MainScreen(),
      },
    );
  }
}
