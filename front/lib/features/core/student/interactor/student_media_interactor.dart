import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class StudentMediaInteractor {
  static const _appMediaFolder = 'Correct speech';

  Future<void> _createAppMediaFolder() async {
    if (Platform.isIOS || Platform.isMacOS) {
      final editor = PhotoManager.editor.darwin;
      await editor.createFolder(_appMediaFolder);
    } else if (Platform.isAndroid) {
      final editor = PhotoManager.editor.android;
      PhotoManager.getAssetPathList();
      await editor.moveAssetToAnother(entity: , target: AssetPathEntity.obtainPathFromProperties(id: id))
    } else {
      throw const OSError('OS not supported');
    }
  }

  _createStudentMediaFolder() {}
}
