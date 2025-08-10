# Video Call App

A Flutter application that implements a simple group video call using GetStream.io Video SDK with clean architecture and BLoC pattern.

## 🏗️ Architecture

This app follows clean architecture principles with:

- **BLoC Pattern** for state management using `flutter_bloc`
- **Separation of Concerns** with dedicated folders for each layer
- **Dependency Injection** through service classes
- **Reusable Components** with custom widgets

## 📁 Project Structure

```
lib/
├── config/
│   └── stream_video_config.dart     # API configuration
├── cubits/
│   ├── permission/
│   │   ├── permission_cubit.dart    # Permission state management
│   │   └── permission_state.dart    # Permission states
│   └── video_call/
│       ├── video_call_cubit.dart    # Video call state management
│       └── video_call_state.dart    # Video call states
├── models/
│   └── user_model.dart              # User data model
├── screens/
│   ├── permission_screen.dart       # Permission request screen
│   └── video_call_screen.dart       # Video call interface
├── services/
│   └── permission_service.dart      # Permission handling service
├── widgets/
│   ├── loading_widget.dart          # Reusable loading widget
│   └── error_widget.dart            # Reusable error widget
└── main.dart                        # App entry point
```

## 🚀 Features

- 🎥 **Group Video Calls**: Support for multiple participants
- 📱 **Responsive Design**: Works on mobile and tablet
- 🔐 **Automatic Authentication**: Random user ID generation
- 🎨 **Modern UI**: Clean, intuitive interface
- 🔒 **Permission Handling**: Camera and microphone permissions
- 📊 **State Management**: BLoC pattern with Cubit
- 🏗️ **Clean Architecture**: Separated concerns and layers

## 🛠️ Setup Instructions

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

### 3. API Configuration
Your API key is already configured: `a6ynvmtxdv3w`

To enable real video calls:
1. Get development token from GetStream dashboard
2. Update `lib/config/stream_video_config.dart`
3. Replace `YOUR_DEVELOPMENT_TOKEN_HERE` with your token

## 🏛️ Architecture Details

### Cubits (State Management)
- **PermissionCubit**: Manages camera/microphone permissions
- **VideoCallCubit**: Manages video call state and connection

### Services
- **PermissionService**: Handles permission requests and status

### Models
- **UserModel**: Represents user data with Equatable for comparison

### Widgets
- **LoadingWidget**: Reusable loading indicator
- **CustomErrorWidget**: Reusable error display

## 🔄 State Flow

1. **App Launch** → PermissionCubit checks permissions
2. **Permission Granted** → Navigate to VideoCallScreen
3. **Video Call** → VideoCallCubit manages call state
4. **Call End** → Return to previous screen

## 🎯 Key Components

### PermissionCubit
```dart
// States: Initial, Loading, Granted, Denied, Error
// Methods: requestPermissions(), checkPermissions(), openSettings()
```

### VideoCallCubit
```dart
// States: Initial, Loading, Connected, Error, Disconnected
// Methods: joinCall(), leaveCall(), updateParticipantCount()
```

### PermissionService
```dart
// Methods: requestPermissions(), arePermissionsGranted(), openSettings()
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

## 📱 Platform Support

- ✅ Android (with permissions)
- ✅ iOS (with permissions)
- ⚠️ Web (limited functionality)

## 🔧 Dependencies

- `flutter_bloc: ^8.1.6` - State management
- `equatable: ^2.0.7` - Value equality
- `permission_handler: ^12.0.1` - Runtime permissions
- `stream_video_flutter: ^0.10.2` - Video SDK

## 🚀 Next Steps

1. **Add Real Video Integration**:
   - Implement StreamVideo SDK in VideoCallCubit
   - Add participant management
   - Add video/audio controls

2. **Enhance UI**:
   - Add participant video tiles
   - Add call controls (mute, camera toggle)
   - Add screen sharing

3. **Add Features**:
   - User authentication
   - Multiple rooms
   - Chat during calls
   - Recording functionality

## 🐛 Troubleshooting

### Common Issues
- **Permissions denied**: Check device settings
- **Build errors**: Run `flutter clean && flutter pub get`
- **State issues**: Check Cubit implementations

### Debug Mode
Enable debug prints in Cubits for detailed state tracking.

## 📄 License

This project is for educational and development purposes.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📞 Support

- [StreamVideo Documentation](https://getstream.io/video/docs/)
- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
