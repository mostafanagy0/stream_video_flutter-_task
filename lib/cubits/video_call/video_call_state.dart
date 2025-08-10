import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

abstract class VideoCallState extends Equatable {
  const VideoCallState();

  @override
  List<Object?> get props => [];
}

class VideoCallInitial extends VideoCallState {}

class VideoCallLoading extends VideoCallState {}

class VideoCallConnected extends VideoCallState {
  final UserModel currentUser;
  final String roomId;
  final int participantCount;

  const VideoCallConnected({
    required this.currentUser,
    required this.roomId,
    this.participantCount = 1,
  });

  @override
  List<Object?> get props => [currentUser, roomId, participantCount];

  VideoCallConnected copyWith({
    UserModel? currentUser,
    String? roomId,
    int? participantCount,
  }) {
    return VideoCallConnected(
      currentUser: currentUser ?? this.currentUser,
      roomId: roomId ?? this.roomId,
      participantCount: participantCount ?? this.participantCount,
    );
  }
}

class VideoCallError extends VideoCallState {
  final String error;

  const VideoCallError(this.error);

  @override
  List<Object?> get props => [error];
}

class VideoCallDisconnected extends VideoCallState {} 