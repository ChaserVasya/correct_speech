import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/student_videos/student_videos_cubit.dart';
import 'package:correct_speech/features/video_comment/presentation/comments_list/comments_list.dart';
import 'package:correct_speech/features/video_import/presentation/widget/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentVideosScreen extends StatefulWidget {
  final RegisteredPerson student;

  const StudentVideosScreen(this.student, {super.key});

  @override
  State<StudentVideosScreen> createState() => _StudentVideosScreenState();
}

class _StudentVideosScreenState extends State<StudentVideosScreen> {
  late final StudentVideosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit.init(widget.student);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: _buildState,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Widget _buildState(BuildContext context, BlocState? state) {
    if (state == null) {
      return const CircularProgressIndicator();
    } else if (state.videos.isEmpty) {
      return const Text('Ещё нет импортированных видео');
    } else {
      return ListView.builder(
        itemBuilder: (_, i) => VideoTile(
          video: state.videosUI[i],
          onTap: () => _openVideoComments(state.videos[i]),
        ),
      );
    }
  }

  void _openVideoComments(RegisteredVideo video) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CommentsList(video: video),
      ),
    );
  }
}
