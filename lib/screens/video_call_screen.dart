import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/video_call/video_call_cubit.dart';
import '../cubits/video_call/video_call_state.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoCallCubit()..joinCall(),
      child: const VideoCallScreenView(),
    );
  }
}

class VideoCallScreenView extends StatelessWidget {
  const VideoCallScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoCallCubit, VideoCallState>(
      listener: (context, state) {
        if (state is VideoCallDisconnected) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<VideoCallCubit, VideoCallState>(
            builder: (context, state) {
              if (state is VideoCallLoading) {
                return const LoadingWidget(
                  message: 'Joining call...',
                  color: Colors.white,
                );
              } else if (state is VideoCallError) {
                return CustomErrorWidget(
                  error: state.error,
                  onRetry: () => context.read<VideoCallCubit>().joinCall(),
                );
              } else if (state is VideoCallConnected) {
                return _buildCallView(context, state);
              }
              
              return const LoadingWidget(
                message: 'Initializing...',
                color: Colors.white,
              );
            },
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildCallView(BuildContext context, VideoCallConnected state) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.videocam,
            color: Colors.white,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Connected to Test Room',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Video call is active',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'API Key: a6ynvmtxdv3w\nReady for StreamVideo integration!',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocBuilder<VideoCallCubit, VideoCallState>(
      builder: (context, state) {
        if (state is VideoCallLoading || state is VideoCallError) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton(
            onPressed: () => context.read<VideoCallCubit>().leaveCall(),
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
} 