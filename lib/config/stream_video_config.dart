// Configuration file for StreamVideo SDK
// Contains API key and settings for video calls

class StreamVideoConfig {
  static const String apiKey = 'yukzvcspafmd';

  static const String developmentToken = 'YOUR_DEVELOPMENT_TOKEN_HERE';

  // Default room settings
  static const String defaultRoomId = 'test-room  ';
  static const String defaultRoomType = 'default';

  // User settings
  static const String userImageUrl = 'https://getstream.io/random_svg/?id=';

  /// Generate a random user ID for demo purposes
  static String generateUserId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'user${timestamp % 10000}';
  }

  /// Get user name from user ID
  static String getUserName(String userId) {
    return 'User $userId';
  }

  /// Get user image URL
  static String getUserImageUrl(String userId) {
    return '$userImageUrl$userId';
  }
}
