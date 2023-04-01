import 'package:correct_speech/feature_framework/presentation/features_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeaturesScreen(),
    );
  }
}
