import 'package:correct_speech/feature_framework/presentation/main_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
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
