import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocNarrowedConsumer<B extends StateStreamable<S>, S, Build extends S, Listen extends S> extends StatelessWidget {
  final B bloc;
  final BlocWidgetBuilder<Build> builder;
  final BlocWidgetListener<Listen> listener;

  const BlocNarrowedConsumer({
    super.key,
    required this.bloc,
    required this.builder,
    required this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      builder: (context, state) => builder(context, state as Build),
      buildWhen: (_, state) => state is Build,
      listener: (context, state) => listener(context, state as Listen),
      listenWhen: (_, state) => state is Listen,
    );
  }
}
