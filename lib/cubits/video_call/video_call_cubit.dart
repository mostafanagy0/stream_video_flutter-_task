import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../config/stream_video_config.dart';
import 'video_call_state.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  VideoCallCubit() : super(VideoCallInitial());

  /// Initialize and join video call
  Future<void> joinCall() async {
    emit(VideoCallLoading());
    
    try {
      // Simulate connection delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Generate user
      final userId = StreamVideoConfig.generateUserId();
      final user = UserModel(
        id: userId,
        name: StreamVideoConfig.getUserName(userId),
        imageUrl: StreamVideoConfig.getUserImageUrl(userId),
      );
      
      // Emit connected state
      emit(VideoCallConnected(
        currentUser: user,
        roomId: StreamVideoConfig.defaultRoomId,
        participantCount: 1,
      ));
    } catch (e) {
      emit(VideoCallError(e.toString()));
    }
  }

  /// Leave the video call
  Future<void> leaveCall() async {
    try {
      // Simulate disconnection
      await Future.delayed(const Duration(milliseconds: 500));
      emit(VideoCallDisconnected());
    } catch (e) {
      emit(VideoCallError(e.toString()));
    }
  }

  /// Update participant count
  void updateParticipantCount(int count) {
    final currentState = state;
    if (currentState is VideoCallConnected) {
      emit(currentState.copyWith(participantCount: count));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(VideoCallInitial());
  }
} 