import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import 'comment_editing_cubit.dart';

class CommentEditingScreen extends StatefulWidget {
  final VideoComment comment;

  const CommentEditingScreen({super.key, required this.comment});

  @override
  State<CommentEditingScreen> createState() => _CommentEditingScreenState();
}

class _CommentEditingScreenState extends State<CommentEditingScreen> {
  late final CommentEditingCubit _cubit;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _cubit = Injector.appInstance.get();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocConsumer(
        bloc: _cubit,
        listener: _listenState,
        builder: _buildState,
      ),
    );
  }

  Widget _buildState(BuildContext context, BlocState state) {
    switch (state) {
      case BlocState.none:
        return TextField(controller: _controller);
      case BlocState.saved:
      case BlocState.waiting:
        return const CircularProgressIndicator();
    }
  }

  void _listenState(BuildContext context, BlocState state) {
    switch (state) {
      case BlocState.saved:
        return Navigator.of(context).pop();
      case BlocState.none:
      case BlocState.waiting:
        return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final result = await _showNotSavedChangesDialog();
    switch (result) {
      case _OnPopActions.saveAndPop:
        _cubit.editComment(VideoComment(
          videoId: widget.comment.videoId,
          comment: _controller.text,
        ));
        return false;
      case _OnPopActions.pop:
        return true;
      case _OnPopActions.stay:
      case null:
        return false;
    }
  }

  Future<_OnPopActions?> _showNotSavedChangesDialog() {
    return showDialog<_OnPopActions>(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('Есть несохранённые изменения'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_OnPopActions.stay),
            child: const Text('Остаться'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_OnPopActions.pop),
            child: const Text('Выйти'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_OnPopActions.saveAndPop),
            child: const Text('Сохранить и выйти'),
          ),
        ],
      ),
    );
  }
}

enum _OnPopActions {
  saveAndPop,
  pop,
  stay,
}
