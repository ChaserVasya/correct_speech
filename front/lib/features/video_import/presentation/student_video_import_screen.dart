import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/presentation/widget/show_student_selection_bottomsheet.dart';
import 'package:correct_speech/features/core/video/presentation/model/video_ui.dart';
import 'package:correct_speech/features/video_import/presentation/student_video_import_bloc.dart';
import 'package:correct_speech/features/video_import/presentation/widget/video_tile.dart';
import 'package:correct_speech/uikit/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class StudentVideoImportScreen extends StatefulWidget {
  const StudentVideoImportScreen({super.key});

  @override
  State<StudentVideoImportScreen> createState() => _StudentVideoImportScreenState();
}

class _StudentVideoImportScreenState extends State<StudentVideoImportScreen> {
  late final StudentVideoImportCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get<StudentVideoImportCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Импорт видео',
      child: BlocBuilder(
        bloc: _cubit,
        builder: _buildState,
      ),
    );
  }

  Widget _buildState(BuildContext context, BlocState state) {
    if (state is BlocStateLoading) {
      return _buildLoadingState();
    } else {
      return _buildMainState(state);
    }
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildMainState(BlocState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSelectVideoButton(),
        _buildSelectedVideo(state.videos),
        _buildStudentOnVideoCard(state.studentOnVideo),
        if (state.studentOnVideo != null) _buildImportVideoButton(),
      ],
    );
  }

  Widget _buildSelectedVideo(List<VideoUI> videos) {
    if (videos.isEmpty) {
      return const Text('Нет выбранных видео');
    }
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        itemCount: videos.length,
        itemBuilder: (_, i) => VideoTile(
          video: videos[i],
        ),
      ),
    );
  }

  Widget _buildSelectVideoButton() {
    return OutlinedButton(
      onPressed: _cubit.pickVideos,
      child: const Text('Выбрать видео'),
    );
  }

  Widget _buildImportVideoButton() {
    return OutlinedButton(
      onPressed: _cubit.moveVideos,
      child: const Text('Импортировать видео'),
    );
  }

  Widget _buildStudentOnVideoCard(RegisteredPerson? studentOnVideo) {
    return OutlinedButton(
      onPressed: _selectStudentOnVideoCard,
      child: Text((studentOnVideo == null)
          ? 'Выберите ученика, в чью папку будут перенесены видео'
          : 'Текущий студент: ${studentOnVideo.fullName}'),
    );
  }

  void _selectStudentOnVideoCard() async {
    final selectedStudent = await showStudentSelectionBottomsheet(context);
    if (selectedStudent == null) return;
    _cubit.studentSelected(selectedStudent);
  }
}
