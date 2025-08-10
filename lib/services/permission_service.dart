import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  /// Request camera and microphone permissions
  Future<bool> requestPermissions() async {
    try {
      // Request camera permission
      final cameraStatus = await Permission.camera.request();
      
      // Request microphone permission
      final microphoneStatus = await Permission.microphone.request();

      // Check if both permissions are granted
      return cameraStatus.isGranted && microphoneStatus.isGranted;
    } catch (e) {
      return false;
    }
  }

  /// Check if permissions are granted
  Future<bool> arePermissionsGranted() async {
    try {
      final cameraStatus = await Permission.camera.status;
      final microphoneStatus = await Permission.microphone.status;
      
      return cameraStatus.isGranted && microphoneStatus.isGranted;
    } catch (e) {
      return false;
    }
  }

  /// Open app settings
  Future<void> openSettings() async {
    await openAppSettings();
  }

  /// Get permission status
  Future<Map<Permission, PermissionStatus>> getPermissionStatus() async {
    return {
      Permission.camera: await Permission.camera.status,
      Permission.microphone: await Permission.microphone.status,
    };
  }
} 