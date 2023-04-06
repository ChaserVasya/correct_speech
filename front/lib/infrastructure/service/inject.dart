import 'package:correct_speech/infrastructure/service/album_importer/album_importer.dart';
import 'package:correct_speech/infrastructure/service/thumbnail_creator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injector/injector.dart';

void injectServices() {
  final register = Injector.appInstance.registerDependency;

  register(() => ThumbnailCreator.new);
  register(() => AlbumImporter.platform);
  register(() => FilePicker.platform);
}
