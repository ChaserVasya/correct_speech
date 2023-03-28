import 'dart:io';

class FileMover {
  Future<void> move({required String sourcePath, required String destinationPath}) async {
    final sourceFile = File(sourcePath);
    await sourceFile.copy(destinationPath);
    await sourceFile.delete();
  }
}
