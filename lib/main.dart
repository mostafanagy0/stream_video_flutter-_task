import 'package:flutter/material.dart';
import 'screens/permission_screen.dart';

void main() {
  runApp(const VideoCallApp());
}

/// Main application widget
class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Call App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PermissionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
