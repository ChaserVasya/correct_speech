import 'package:flutter/material.dart';

class FeatureBase extends StatelessWidget {
  final Map<String, WidgetBuilder> routes;

  const FeatureBase({
    super.key,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final WidgetBuilder screenBuilder = routes[name]!;

    return MaterialPageRoute<dynamic>(
      builder: screenBuilder,
      settings: settings,
    );
  }
}
