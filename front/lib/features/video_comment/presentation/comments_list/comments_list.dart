import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_creation/comment_creation_screen.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_tile/comment_card.dart';
import 'package:correct_speech/features/video_comment/presentation/comments_list/comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class CommentsList extends StatefulWidget {
  final RegisteredVideo video;

  const CommentsList({
    super.key,
    required this.video,
  });

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  late final CommentsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
    _cubit.init(widget.video);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, List<VideoComment>? comments) {
    if (comments == null) {
      return _buildNotInited();
    }
    return _buildComments(comments);
  }

  Widget _buildComments(List<VideoComment> comments) {
    return ListView(
      children: [
        for (final comment in comments) CommentCard(comment),
        ElevatedButton(
          onPressed: _pushCommentCreationScreen,
          child: const Text('Добавить комментарий'),
        ),
      ],
    );
  }

  void _pushCommentCreationScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CommentCreationScreen(videoId: widget.video.id),
    ));
  }

  Widget _buildNotInited() {
    return const CircularProgressIndicator();
  }
}
