import 'package:correct_speech/features/video_comment/data/dao/video_comment_dao.dart';
import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:correct_speech/features/video_comment/data/mapper/video_comment_mapper.dart';
import 'package:correct_speech/features/video_comment/domain/interface/video_comment_repository.dart';
import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';

class VideoCommentRepositoryDB implements VideoCommentRepository {
  final VideoCommentDao _videoCommentDao;
  final VideoCommentMapper _mapper;

  VideoCommentRepositoryDB(
    this._videoCommentDao,
    this._mapper,
  );

  @override
  Future<List<VideoComment>> getCommentsOfVideo(int videoId) async {
    final table = await _videoCommentDao.getVideoComments(videoId);
    return _mapCommentsTableToDomain(table);
  }

  @override
  Stream<List<VideoComment>> streamCommentsOfVideo(int videoId) async* {
    final commentsTableStream = _videoCommentDao.streamVideoComments(videoId);
    yield* commentsTableStream.map(_mapCommentsTableToDomain);
  }

  List<VideoComment> _mapCommentsTableToDomain(List<VideoCommentEntry> table) {
    return table.map(_mapper.toDomain).toList();
  }

  @override
  Future<void> addComment(VideoComment comment) async {
    final entry = _mapper.toEntry(comment);
    await _videoCommentDao.insertVideoComment(entry);
  }

  @override
  Future<void> deleteComment(VideoComment comment) async {
    final entry = _mapper.toEntry(comment);
    await _videoCommentDao.deleteVideoComment(entry);
  }

  @override
  Future<void> updateComment(VideoComment comment) async {
    final entry = _mapper.toEntry(comment);
    await _videoCommentDao.updateVideoComment(entry);
  }
}
