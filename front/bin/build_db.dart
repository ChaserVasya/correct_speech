// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) async {
  const command = r'flutter packages pub run build_runner build';

  final result = await Process.run(
    'zsh',
    ['-c', command],
  );

  print('stdout:');
  print(result.stdout.toString());

  print('stderr:');
  print(result.stderr.toString());
}

Future<ProcessResult> runOnPlatform(String command) {
  if (Platform.isWindows) {
    return Process.run('powershell', [command]);
  } else if (Platform.isMacOS) {
    return Process.run('zsh', ['-c', command]);
  } else {
    throw Exception('Unsupported platform');
  }
}
