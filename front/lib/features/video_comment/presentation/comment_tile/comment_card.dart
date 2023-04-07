import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:correct_speech/features/video_comment/presentation/comment_editing/comment_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'comment_cubit/comment_cubit.dart';

class CommentCard extends StatefulWidget {
  final VideoComment comment;

  const CommentCard(
    this.comment, {
    super.key,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late final CommentCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.comment.comment, overflow: TextOverflow.clip),
      onTap: _pushCommentEditingScreen,
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _cubit.deleteComment(widget.comment),
      ),
    );
  }

  void _pushCommentEditingScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CommentEditingScreen(
          comment: widget.comment,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
