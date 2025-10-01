# Mindful Journal

A Flutter application for mindful journaling, featuring AI-powered insights, user authentication, and local data storage.

## Features

- **User Authentication**: Secure login and registration using Firebase Authentication.
- **Journal Entries**: Create, edit, and manage personal journal entries.
- **AI-Powered Insights**: Leverage Firebase AI to gain insights and analysis from your journal entries.
- **Offline Storage**: Local SQLite database for storing entries offline using Sqflite.
- **Cross-Platform**: Supports Android, iOS, Web, Windows, macOS, and Linux.

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.9.2 or higher)
- [Dart](https://dart.dev/get-dart) (comes with Flutter)
- A Firebase project for authentication and AI services

### Setup

1. **Clone the repository**:

   ```bash
   git clone https://github.com/AvishkaGihan/mindful_journal.git
   cd mindful_journal
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:

   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Enable Authentication and AI services in your Firebase project.
   - For mobile apps:
     - Add Android/iOS app to your Firebase project.
     - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them in the respective directories:
       - Android: `android/app/google-services.json`
       - iOS: `ios/Runner/GoogleService-Info.plist`
   - For web apps, configure Firebase in the web console and update `lib/firebase_options.dart` if necessary.

4. **Run the app**:

   ```bash
   flutter run
   ```

   For specific platforms:

   - Android: `flutter run --device-id=<device_id>`
   - iOS: `flutter run --device-id=<device_id>`
   - Web: `flutter run -d chrome`

## Usage

1. **Launch the app**: Open the app on your device or emulator.
2. **Sign In/Sign Up**: Use Firebase Authentication to create an account or log in.
3. **Create Entries**: Navigate to the home screen to add new journal entries.
4. **View Insights**: Access AI-generated insights on your journal entries.
5. **Manage Data**: Edit or delete entries as needed. Data is stored locally and synced where applicable.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── entry.dart            # Journal entry model
├── providers/
│   └── entry_provider.dart   # State management for entries
├── repositories/
│   └── database_repository.dart # Database operations
├── screens/
│   ├── home_screen.dart      # Main journal screen
│   ├── add_edit_entry_screen.dart # Add/edit entry screen
│   └── login_screen.dart     # Authentication screen
└── services/
    ├── ai_service.dart       # AI integration service
    └── auth_service.dart     # Authentication service
```

## Dependencies

- `firebase_core`: Firebase core functionality
- `firebase_auth`: Firebase Authentication
- `firebase_ai`: Firebase AI services
- `provider`: State management
- `sqflite`: SQLite database
- `path`: File path utilities
- `intl`: Internationalization

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
