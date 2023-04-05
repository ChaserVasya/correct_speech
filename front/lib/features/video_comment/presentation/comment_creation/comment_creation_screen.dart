import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import 'comment_creation_cubit.dart';

class CommentCreationScreen extends StatefulWidget {
  final int videoId;

  const CommentCreationScreen({super.key, required this.videoId});

  @override
  State<CommentCreationScreen> createState() => _CommentCreationScreenState();
}

class _CommentCreationScreenState extends State<CommentCreationScreen> {
  late final CommentCreationCubit _cubit;
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

  Future<bool> _onWillPop() async {
    final result = await _showNotSavedChangesDialog();
    switch (result) {
      case _OnPopActions.saveAndPop:
        _cubit.createComment(VideoComment(
          videoId: widget.videoId,
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

  @override
  void dispose() {
    _cubit.close();
    _controller.dispose();
    super.dispose();
  }
}

enum _OnPopActions {
  saveAndPop,
  pop,
  stay,
}
