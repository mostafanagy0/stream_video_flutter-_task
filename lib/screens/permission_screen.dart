import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/widgets/retray_botton.dart';
import 'package:video_call_app/widgets/settings_botton.dart';

import '../cubits/permission/permission_cubit.dart';
import '../cubits/permission/permission_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'video_call_screen.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionCubit()..checkPermissions(),
      child: const PermissionScreenView(),
    );
  }
}

class PermissionScreenView extends StatelessWidget {
  const PermissionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionCubit, PermissionState>(
      listener: (context, state) {
        if (state is PermissionGranted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const VideoCallScreen()),
          );
        }
      },
      child: BlocBuilder<PermissionCubit, PermissionState>(
        builder: (context, state) {
          if (state is PermissionLoading) {
            return _buildLoadingView();
          } else if (state is PermissionDenied) {
            return _buildPermissionDeniedView(context, state.message);
          } else if (state is PermissionError) {
            return CustomErrorWidget(
              error: state.error,
              onRetry: () =>
                  context.read<PermissionCubit>().requestPermissions(),
            );
          }

          return _buildPermissionDeniedView(
            context,
            'Camera and microphone permissions are required for video calls.',
          );
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const LoadingWidget(
        message:
            'Requesting permissions...\nCamera and microphone access required',
        color: Colors.white,
      ),
    );
  }

  Widget _buildPermissionDeniedView(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Permission denied icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 60,
                  color: Colors.red.shade600,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                'Permissions Required',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Action buttons
              Column(
                children: [
                  // Retry button
                  RetryBotton(),
                  const SizedBox(height: 12),
                  // Settings button
                  SettingsButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
