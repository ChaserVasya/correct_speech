import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  List<String> pathes = ['false'];

  @override
  void initState() {
    super.initState();
    Future(() async {
      await Permission.manageExternalStorage.request();
      // final file = await File('/test.txt').create(recursive: true);
      // final dir = await getExternalStorageDirectory();
      const deviceInternalPath = '/storage/emulated/0/Android';
      final file = await File(join(deviceInternalPath, 'testDir')).create();
      // final res = await Directory(join(path!.path, 'testDir')).create();
      // final assets = await PhotoManager.getAssetPathList(
      //   onlyAll: true,
      // );
      // final all = assets.single;
      // final res = await PhotoManager.editor.android.moveAssetToAnother(
      //   entity: ,
      //   target: all,
      // );
      // pathes.add(res.toString());
      pathes = [file.path];
      print(pathes);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = pathes.map<Widget>((e) => Text(e)).toList()
      ..add(ElevatedButton(
        onPressed: () => setState(() {}),
        child: Text('push me'),
      ));
    return Container(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: pathes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => h[i],
        ));
  }
}
