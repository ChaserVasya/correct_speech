import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/video/data/dao/video_dao.dart';
import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:correct_speech/features/core/video/data/mapper/video_mapper.dart';
import 'package:correct_speech/features/core/video/domain/interface/video_repository.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';
import 'package:correct_speech/infrastructure/helper/periodic_stream.dart';

class VideoRepositoryDb extends VideoRepository {
  final VideoDao _videoDao;
  final VideoMapper _mapper;

  VideoRepositoryDb(
    this._videoDao,
    this._mapper,
  );

  @override
  Future<RegisteredVideo?> getVideo(int id) async {
    final entry = await _videoDao.getVideoById(id);
    if (entry == null) return null;
    return _mapper.toDomain(entry);
  }

  @override
  Future<List<RegisteredVideo>> getVideosByAuthor(int authorId) async {
    final table = await _videoDao.getVideosByAuthor(authorId);
    return _mapVideosTableToDomain(table);
  }

  @override
  Stream<List<RegisteredVideo>> streamVideosByAuthor(int authorId) {
    return periodicStream(() => getVideosByAuthor(authorId));
  }

  List<RegisteredVideo> _mapVideosTableToDomain(List<VideoEntry> table) {
    return table.map(_mapper.toDomain).toList();
  }

  @override
  Future<RegisteredVideo> addVideo(Video video, Registered author) async {
    final entry = _mapper.toInsertEntry(video, author.id);
    final id = await _videoDao.insertVideo(entry);
    return RegisteredVideo(id: id, authorId: author.id, path: video.path);
  }

  @override
  Future<void> deleteVideo(RegisteredVideo video) async {
    final entry = _mapper.toEntry(video);
    return _videoDao.deleteVideo(entry);
  }

  @override
  Future<void> updateVideo(RegisteredVideo video) async {
    final entry = _mapper.toEntry(video);
    return _videoDao.updateVideo(entry);
  }
}
