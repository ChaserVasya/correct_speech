import 'package:correct_speech/features/core/export.dart';
import 'package:correct_speech/features/student_video_import/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' hide Builder;

class StudentVideoImportScreen extends StatefulWidget {
  const StudentVideoImportScreen({super.key});

  @override
  State<StudentVideoImportScreen> createState() => _StudentVideoImportScreenState();
}

class _StudentVideoImportScreenState extends State<StudentVideoImportScreen> {
  late final StudentVideoImportBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Injector.appInstance.get<StudentVideoImportBloc>();
  }

  @override
  void dispose() async {
    await _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      builder: _buildState,
      listener: (context, state) async {
        if (state is StudentVideoImportStateStudentNotSelected) {
          await _showDialogNotSelectedStudent(context);
        }
      },
    );
  }

  Future<T?> _showDialogNotSelectedStudent<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (_) => const SimpleDialog(
        title: Text('Для перемещения видео необходимо выбрать ученика'),
      ),
    );
  }

  Widget _buildState(BuildContext context, StudentVideoImportState state) {
    if (state is StudentVideoImportStateInit) {
      return _buildInitState();
    } else if (state is StudentVideoImportStateMain) {
      return _buildMainState(state);
    } else {
      throw Exception();
      //TODO do exception system
    }
  }

  Widget _buildInitState() {
    return const CircularProgressIndicator();
  }

  Widget _buildMainState(StudentVideoImportStateMain state) {
    return Column(
      children: [
        _buildSelectVideoButton(),
        _buildSelectedVideo(state.videosInfo),
        _buildStudentOnVideoCard(state.studentOnVideo),
      ],
    );
  }

  Widget _buildSelectedVideo(List<VideoInfo> videosInfo) {
    return ListView.builder(
      itemCount: videosInfo.length,
      itemBuilder: (_, i) => VideoTile(
        video: videosInfo[i],
      ),
    );
  }

  Widget _buildSelectVideoButton() {
    return OutlinedButton(
      onPressed: () => _bloc.add(StudentVideoImportEventPickVideos()),
      child: const Text('Выбрать видео'),
    );
  }

  Widget _buildStudentOnVideoCard(Student? studentOnVideo) {
    return TextButton(
      onPressed: () async {
        final selectedStudent = await showStudentSelectionBottomsheet(context);
        _bloc.add(StudentVideoImportEventStudentSelected(selectedStudent));
      },
      child: Text((studentOnVideo == null)
          ? 'Выберите ученика, в чью папку будут перенесены видео'
          : 'Текущий студент: ${studentOnVideo.fullName}'),
    );
  }
}
