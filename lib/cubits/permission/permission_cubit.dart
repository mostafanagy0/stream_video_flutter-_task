import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/permission_service.dart';
import 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionService _permissionService;

  PermissionCubit({PermissionService? permissionService})
      : _permissionService = permissionService ?? PermissionService(),
        super(PermissionInitial());

  /// Request camera and microphone permissions
  Future<void> requestPermissions() async {
    emit(PermissionLoading());
    
    try {
      final isGranted = await _permissionService.requestPermissions();
      
      if (isGranted) {
        emit(PermissionGranted());
      } else {
        emit(const PermissionDenied());
      }
    } catch (e) {
      emit(PermissionError(e.toString()));
    }
  }

  /// Check if permissions are already granted
  Future<void> checkPermissions() async {
    emit(PermissionLoading());
    
    try {
      final isGranted = await _permissionService.arePermissionsGranted();
      
      if (isGranted) {
        emit(PermissionGranted());
      } else {
        emit(const PermissionDenied());
      }
    } catch (e) {
      emit(PermissionError(e.toString()));
    }
  }

  /// Open app settings
  Future<void> openSettings() async {
    await _permissionService.openSettings();
  }

  /// Reset to initial state
  void reset() {
    emit(PermissionInitial());
  }
} 