import 'package:correct_speech/feature_framework/model/feature.dart';
import 'package:correct_speech/feature_framework/presentation/widget/feature_base.dart';
import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  final Feature feature;

  const FeatureTile({
    Key? key,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _openFeature(context),
      child: Column(
        children: [
          Image.asset(
            feature.iconPath,
            width: 100,
            height: 100,
          ),
          Text(feature.name),
        ],
      ),
    );
  }

  Future _openFeature(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FeatureBase(
          routes: feature.routes,
        ),
      ),
    );
  }
}
