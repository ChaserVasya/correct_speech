import 'package:flutter/material.dart';

Future<T?> showSelectionBottomsheet<T>({
  required BuildContext context,
  required List<T> items,
  required String Function(T) createTitle,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (_) => SelectionBottomsheetBody(
      createTitle: createTitle,
      items: items,
    ),
  );
}

class SelectionBottomsheetBody<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) createTitle;

  const SelectionBottomsheetBody({
    super.key,
    required this.items,
    required this.createTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        items.length,
        (i) => ListTile(
          title: Text(createTitle(items[i])),
          onTap: () => Navigator.of(context).pop(items[i]),
        ),
      ),
    );
  }
}
