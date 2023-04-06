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
    return InkWell(
      onTap: () => _openFeature(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(feature.iconPath),
              ),
            ),
            Text(feature.name, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
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
