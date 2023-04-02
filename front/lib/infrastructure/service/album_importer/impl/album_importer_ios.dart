import 'dart:io';

import 'package:correct_speech/infrastructure/extensions.dart';
import 'package:correct_speech/infrastructure/file_structure_constants.dart';
import 'package:correct_speech/infrastructure/service/album_importer/album_importer.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumImporterIOS implements AlbumImporter {
  @override
  Future<String> import(File file, String albumName) async {
    final appDir = await _getAppDir();
    final album = await _getAlbum(albumName, appDir);
    final imported = await _moveToAlbum(file, album);
    return (await imported.originFile)!.path;
  }

  Future<AssetPathEntity> _getAppDir() async {
    final root = (await PhotoManager.getAssetPathList(hasAll: true, onlyAll: true)).single;
    final rootDirs = await root.getSubPathList();
    var appDir = rootDirs.singleWhereOrVoid((dir) => dir.name == FileStructureConstants.appFolder);
    if (appDir != null) return appDir;

    appDir = await PhotoManager.editor.darwin.createFolder(FileStructureConstants.appFolder);
    return appDir!;
  }

  Future<AssetPathEntity> _getAlbum(String name, AssetPathEntity appDir) async {
    final album = await PhotoManager.editor.darwin.createAlbum(name, parent: appDir);
    return album!;
  }

  Future<AssetEntity> _moveToAlbum(File file, AssetPathEntity album) async {
    final sourceAsset = await PhotoManager.editor.saveVideo(file, title: basename(file.path));
    final targetAsset = await PhotoManager.editor.copyAssetToPath(asset: sourceAsset!, pathEntity: album);
    await _deleteFileAndAsset(sourceAsset);
    return targetAsset!;
  }

  Future<void> _deleteFileAndAsset(AssetEntity entity) async {
    await PhotoManager.editor.deleteWithIds([entity.id]);
    await File((await entity.originFile)!.path).delete();
    PhotoManager.clearFileCache();
  }
}
