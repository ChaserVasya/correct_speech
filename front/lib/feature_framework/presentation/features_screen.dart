import 'package:correct_speech/feature_framework/features.dart';
import 'package:correct_speech/feature_framework/presentation/widget/feature_tile.dart';
import 'package:correct_speech/uikit/base_screen.dart';
import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Сервисы',
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: [
          for (final feature in features) FeatureTile(feature: feature),
        ],
      ),
    );
  }
}
