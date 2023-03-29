import 'dart:developer';
import 'dart:io';

void main(List<String> args) async {
  const command = r'flutter packages pub run build_runner build';

  final result = await Process.run(
    'powershell',
    [command],
  );

  log(result.stdout.toString());
}
