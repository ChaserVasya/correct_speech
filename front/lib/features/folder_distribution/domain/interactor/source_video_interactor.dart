import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/folder_distribution/export.dart';
import 'package:file_picker/file_picker.dart';

class SourceVideoInteractor {
  final VideoInfoMapper _videoInfoMapper;
  final FilePicker _filePicker;

  SourceVideoInteractor(
    VideoInfoMapper videoInfoMapper,
    FilePicker filePicker,
  )   : _videoInfoMapper = videoInfoMapper,
        _filePicker = filePicker;

  Future<List<VideoInfo>> pickVideos() async {
    final result = await _filePicker.pickFiles(
      allowMultiple: true,
      type: FileType.video,
      lockParentWindow: true,
    );

    return await _videoInfoMapper.fromFilePickerResult(result!);
  }
}
