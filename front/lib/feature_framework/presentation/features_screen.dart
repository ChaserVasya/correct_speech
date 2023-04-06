import 'package:correct_speech/feature_framework/features.dart';
import 'package:correct_speech/feature_framework/presentation/widget/feature_tile.dart';
import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello')),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: [
          for (final feature in features) FeatureTile(feature: feature),
        ],
      ),
    );
  }
}
