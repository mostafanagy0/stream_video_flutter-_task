# Architecture Documentation

## 🏗️ Clean Architecture Overview

This app follows clean architecture principles with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                   │
├─────────────────────────────────────────────────────────────┤
│  Screens (UI)                                               │
│  ├── permission_screen.dart                                 │
│  └── video_call_screen.dart                                 │
│                                                             │
│  Widgets (Reusable Components)                              │
│  ├── loading_widget.dart                                    │
│  └── error_widget.dart                                      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                        BUSINESS LOGIC LAYER                 │
├─────────────────────────────────────────────────────────────┤
│  Cubits (State Management)                                  │
│  ├── permission/                                            │
│  │   ├── permission_cubit.dart                              │
│  │   └── permission_state.dart                              │
│  └── video_call/                                            │
│      ├── video_call_cubit.dart                              │
│      └── video_call_state.dart                              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATA LAYER                           │
├─────────────────────────────────────────────────────────────┤
│  Models                                                      │
│  └── user_model.dart                                        │
│                                                             │
│  Services                                                    │
│  └── permission_service.dart                                │
│                                                             │
│  Config                                                      │
│  └── stream_video_config.dart                               │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow

### 1. Permission Flow
```
User Action → PermissionCubit → PermissionService → PermissionState → UI Update
```

### 2. Video Call Flow
```
User Action → VideoCallCubit → StreamVideoConfig → VideoCallState → UI Update
```

## 📦 Component Details

### Presentation Layer

#### Screens
- **PermissionScreen**: Handles permission requests and UI
- **VideoCallScreen**: Manages video call interface

#### Widgets
- **LoadingWidget**: Reusable loading indicator
- **CustomErrorWidget**: Reusable error display

### Business Logic Layer

#### PermissionCubit
```dart
States:
- PermissionInitial
- PermissionLoading
- PermissionGranted
- PermissionDenied
- PermissionError

Methods:
- requestPermissions()
- checkPermissions()
- openSettings()
```

#### VideoCallCubit
```dart
States:
- VideoCallInitial
- VideoCallLoading
- VideoCallConnected
- VideoCallError
- VideoCallDisconnected

Methods:
- joinCall()
- leaveCall()
- updateParticipantCount()
```

### Data Layer

#### Models
- **UserModel**: User data with Equatable support

#### Services
- **PermissionService**: Permission handling logic

#### Config
- **StreamVideoConfig**: API configuration and utilities

## 🎯 Benefits of This Architecture

### 1. Separation of Concerns
- UI logic separated from business logic
- State management isolated in Cubits
- Services handle external dependencies

### 2. Testability
- Each layer can be tested independently
- Cubits can be unit tested
- Services can be mocked

### 3. Maintainability
- Clear folder structure
- Reusable components
- Easy to add new features

### 4. Scalability
- Easy to add new screens
- Simple to extend state management
- Modular service architecture

## 🔧 Dependency Injection

The app uses simple dependency injection through constructor injection:

```dart
// Service injection
class PermissionCubit extends Cubit<PermissionState> {
  final PermissionService _permissionService;
  
  PermissionCubit({PermissionService? permissionService})
      : _permissionService = permissionService ?? PermissionService(),
        super(PermissionInitial());
}
```

## 🚀 Adding New Features

### 1. New Screen
1. Create screen in `lib/screens/`
2. Add corresponding Cubit if needed
3. Update navigation

### 2. New Service
1. Create service in `lib/services/`
2. Inject into Cubit
3. Add error handling

### 3. New Widget
1. Create widget in `lib/widgets/`
2. Make it reusable
3. Add proper documentation

## 📝 Best Practices

### 1. State Management
- Use Cubit for simple state management
- Keep states immutable
- Use Equatable for state comparison

### 2. Error Handling
- Handle errors in Cubits
- Show user-friendly error messages
- Provide retry mechanisms

### 3. Code Organization
- Keep files focused and small
- Use meaningful names
- Add proper documentation

### 4. Testing
- Test Cubits independently
- Mock services for testing
- Test UI components

## 🔍 Debugging

### Enable Debug Mode
```dart
// In Cubits, add debug prints
void someMethod() {
  print('Cubit: someMethod called');
  // ... implementation
}
```

### State Tracking
```dart
// Listen to state changes
BlocListener<MyCubit, MyState>(
  listener: (context, state) {
    print('State changed to: $state');
  },
  child: // ... widget
)
```

## 📚 Resources

- [BLoC Documentation](https://bloclibrary.dev/)
- [Flutter Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Testing](https://flutter.dev/docs/testing) 