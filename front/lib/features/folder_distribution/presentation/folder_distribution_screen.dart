import 'package:correct_speech/features/folder_distribution/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderDistributionScreen extends StatelessWidget {
  const FolderDistributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => 
      (),
      child: _buildState(),
    );
  }

  Widget _buildState() {
    return BlocBuilder<FolderDistributionBloc, FolderDistributionState>(
      builder: (context, state) {
        if (state is FolderDistributionStateInit) {
          return _buildInitState();
        } else if (state is FolderDistributionStateMain) {
          return _buildMainState(state);
        } else {
          throw Exception();
          //TODO do exception system
        }
      },
    );
  }

  Widget _buildInitState() {
    return const CircularProgressIndicator();
  }

  Widget _buildMainState(FolderDistributionStateMain state) {
    return Column(
      children: [
        _buildVideoSourceCard(state),
        _buildVideoGrid(state),
      ],
    );
  }

  Widget _buildVideoGrid(FolderDistributionStateMain state) {
    return Builder(
      builder: (context) {
        return GridView.count(
          crossAxisCount: state.selectedVideos.length,
          children: List.generate(
            state.selectedVideos.length,
            (i) => VideoTile(
              video: state.videos[i],
              isSelected: state.selectedVideos[i],
              onPressed: () => context
                  .read<FolderDistributionBloc>()
                  .add(FolderDistributionEventVideoPressed(selectedVideoIndex: i)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoSourceCard(FolderDistributionStateMain state) {
    return OutlinedButton(
      onPressed: _chooseNewSourceFolder,
      child: Column(
        children: [
          const Text('Исходная папка'),
          Text(state.videoSourcePath),
        ],
      ),
    );
  }

  void _chooseNewSourceFolder() {}
}
