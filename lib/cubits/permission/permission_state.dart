import 'package:equatable/equatable.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object?> get props => [];
}

class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionDenied extends PermissionState {
  final String message;

  const PermissionDenied({this.message = 'Camera and microphone permissions are required for video calls.'});

  @override
  List<Object?> get props => [message];
}

class PermissionError extends PermissionState {
  final String error;

  const PermissionError(this.error);

  @override
  List<Object?> get props => [error];
} 