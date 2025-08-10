# Quick Start Guide

## 🚀 Getting Started

### 1. Run the Demo App
```bash
flutter pub get
flutter run
```

The app will:
- Request camera and microphone permissions
- Show a demo video call interface
- Display connection status

### 2. What You'll See
- **Permission Screen**: Requests camera and microphone access
- **Demo Call Screen**: Shows a simulated video call interface
- **End Call Button**: Red floating action button to exit

## 🔧 Adding Real Video Calls

### Step 1: Your API Key is Ready! ✅
Your GetStream.io API key is already configured: `a6ynvmtxdv3w`

### Step 2: Get Development Token
1. Go to [GetStream.io Dashboard](https://dashboard.getstream.io)
2. Navigate to your app settings
3. Go to "Tokens" section
4. Generate a development token
5. Copy the token

### Step 3: Update the Configuration
In `lib/stream_video_config.dart`, replace the placeholder token:

```dart
// Replace this line:
static const String developmentToken = 'YOUR_DEVELOPMENT_TOKEN_HERE';

// With your actual token:
static const String developmentToken = 'your_actual_token_here';
```

### Step 4: Implement Video Calls
Create a new file `lib/video_call_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'stream_video_config.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  StreamVideoClient? _client;
  Call? _call;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeCall();
  }

  Future<void> _initializeCall() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Generate user ID
      final userId = StreamVideoConfig.generateUserId();
      
      // Create user
      final user = User(
        info: UserInfo(
          id: userId,
          name: StreamVideoConfig.getUserName(userId),
          image: StreamVideoConfig.getUserImageUrl(userId),
        ),
      );

      // Initialize client
      _client = StreamVideoClient(
        apiKey: StreamVideoConfig.apiKey,
        user: user,
        token: StreamVideoConfig.developmentToken,
      );

      // Connect
      await _client!.connect();

      // Create call
      _call = _client!.call(
        type: StreamVideoConfig.defaultRoomType,
        id: StreamVideoConfig.defaultRoomId,
      );

      // Join call
      await _call!.join();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to join call: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : const Center(
              child: Text(
                'Video Call Active!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_call != null) await _call!.leave();
          if (_client != null) await _client!.disconnect();
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end, color: Colors.white),
      ),
    );
  }
}
```

### Step 5: Update Main App
In `lib/main.dart`, replace `SimpleCallScreen` with `VideoCallScreen`:

```dart
// Add this import
import 'video_call_screen.dart';

// Replace this line:
return const SimpleCallScreen();

// With this:
return const VideoCallScreen();
```

### Step 6: Test with Multiple Devices
1. Build the app: `flutter build apk --release`
2. Install on multiple devices
3. All devices will join the same "test-room"

## 📱 Features Included

✅ **Permission Handling**
- Automatic camera/microphone permission requests
- User-friendly permission denied UI
- Settings access for manual permission granting

✅ **Modern UI**
- Clean, responsive design
- Loading states and error handling
- Material Design 3 components

✅ **API Key Ready**
- Your API key `a6ynvmtxdv3w` is already configured
- Configuration file ready for use
- Example implementation provided

## 🎯 Next Steps

1. **Get Development Token**: Generate token from GetStream dashboard
2. **Implement Video UI**: Add participant video tiles
3. **Add Controls**: Mute, camera toggle, screen sharing
4. **Test**: Try with real devices

## 🐛 Troubleshooting

### Common Issues
- **Permissions denied**: Check device settings
- **Build errors**: Run `flutter clean && flutter pub get`
- **API errors**: Verify your development token is correct

### Getting Help
- [StreamVideo Documentation](https://getstream.io/video/docs/)
- [Flutter Documentation](https://flutter.dev/docs)
- Create an issue in this repository

## 📝 Notes

- ✅ API Key configured: `a6ynvmtxdv3w`
- ⚠️ Need to add development token
- 📁 Configuration file: `lib/stream_video_config.dart`
- 🎥 Ready for real video call implementation 