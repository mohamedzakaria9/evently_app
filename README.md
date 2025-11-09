# Evently App

Evently is a modern Flutter-based event management application that helps users discover, create, and manage events. The app provides a seamless experience for organizing various types of events with features like location mapping, favorites, and multi-language support.

## 📱 Features

- **User Authentication**: Secure login and registration with Firebase Authentication
- **Event Management**: Create, view, and manage events with detailed information
- **Event Categories**: Support for multiple event types including:
  - Sport
  - Birthday
  - Meeting
  - Gaming
  - Workshop
  - Book Club
  - Exhibition
  - Holiday
  - Eating
- **Interactive Maps**: View event locations using Google Maps integration
- **Favorites**: Save your favorite events for quick access
- **Multi-language Support**: Available in English and Arabic
- **Theme Support**: Light and dark mode for comfortable viewing
- **Search Functionality**: Easily search for events
- **Event Details**: Comprehensive event information including date, time, location, and description

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1
- **State Management**: Provider
- **Backend**: Firebase
  - Firebase Authentication
  - Cloud Firestore
- **Maps**: Google Maps Flutter
- **Localization**: Flutter Localizations (English & Arabic)
- **Storage**: Shared Preferences

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account and project setup
- Google Maps API key

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd evently_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your Android and iOS apps to the Firebase project
   - Download `google-services.json` for Android and place it in `android/app/`
   - Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`
   - Run `flutterfire configure` to generate `firebase_options.dart`

4. **Google Maps Setup**
   - Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Add the API key to your platform-specific configuration files

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Download

### Download the Application

You can download the Evently app from the following platforms:

#### Android
- [Download APK]([https://your-download-link-here](https://drive.google.com/file/d/1QhrIwMGf7BulFxzpg1Bl9oMJo4y8EXHa/view?usp=sharing)) - Direct APK download
- [Google Play Store]() - Coming soon

#### iOS
- [App Store]() - Coming soon

## 🏗️ Project Structure

```
lib/
├── api_keys/          # API key configurations
├── firebase_options.dart
├── FirebaseUtiles.dart
├── l10n/              # Localization files
├── main.dart          # App entry point
├── models/            # Data models
├── providers/         # State management providers
├── Routes.dart        # App routing
├── sharedPreferance/  # Local storage
├── theme/             # App themes
├── ui/                # UI screens
└── utilites/          # Utility functions
```

## 🎨 Screenshots

_Add screenshots of your app here_

## 🔧 Configuration

### Environment Variables
Make sure to configure the following:
- Firebase configuration files
- Google Maps API key
- Any other API keys required

### Localization
The app supports English and Arabic. Localization files are located in `lib/l10n/`.

## 📝 Usage

1. **Sign Up / Login**: Create an account or login with existing credentials
2. **Browse Events**: View all available events on the home screen
3. **Search Events**: Use the search functionality to find specific events
4. **Create Event**: Tap the add button to create a new event
5. **View Details**: Tap on any event to see detailed information
6. **Add to Favorites**: Mark events as favorites for quick access
7. **View on Map**: See event locations on an interactive map
8. **Customize**: Switch between light/dark theme and change language in settings

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
