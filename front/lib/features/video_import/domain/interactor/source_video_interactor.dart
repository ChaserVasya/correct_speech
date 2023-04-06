import 'package:file_picker/file_picker.dart';

class SourceVideoInteractor {
  final FilePicker _filePicker;

  SourceVideoInteractor(
    this._filePicker,
  );

  Future<Iterable<String>> pickVideos() async {
    final result = await _filePicker.pickFiles(
      allowMultiple: true,
      type: FileType.video,
      lockParentWindow: true,
    );

    return result!.files.map((file) => file.path!);
  }
}
