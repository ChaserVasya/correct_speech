import 'package:correct_speech/framework/presentation/widgets/servise_tile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello')),
      body: GridView.count(
        crossAxisCount: 1,
        children: const [
          ServiseTile(),
        ],
      ),
    );
  }
}
