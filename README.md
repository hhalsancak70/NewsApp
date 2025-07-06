# News App

A modern Flutter news application that fetches real-time news using the NewsAPI.

## Features

- 📰 Real-time news updates
- 🔄 Pull-to-refresh functionality
- 🖼️ Beautiful UI with smooth animations
- 📱 Responsive design
- 🔍 Detailed news view
- 💫 Hero animations for smooth transitions

## Screenshots

[Add your app screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK
- NewsAPI Key (Get it from [NewsAPI](https://newsapi.org/))

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/news_app.git
```

2. Navigate to the project directory
```bash
cd news_app
```

3. Install dependencies
```bash
flutter pub get
```

### Configuration

⚠️ **Important**: Before running the app, you need to add your NewsAPI key:

1. Open `lib/services/news_service.dart`
2. Replace `YOUR_API_KEY` with your actual NewsAPI key:
```dart
static const String _apiKey = 'YOUR_API_KEY';
```

### Running the App

```bash
flutter run
```

## Architecture

The app follows a simple and clean architecture:

```
lib/
  ├── models/
  │   └── article_model.dart
  ├── screens/
  │   ├── home_screen.dart
  │   └── article_detail_screen.dart
  ├── services/
  │   └── news_service.dart
  ├── widgets/
  │   └── article_card.dart
  └── main.dart
```

## Dependencies

- `http`: For making API requests
- `cached_network_image`: For image caching
- `intl`: For date formatting
- `pull_to_refresh`: For refresh functionality

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## Acknowledgments

- [NewsAPI](https://newsapi.org/) for providing the news data
- Flutter team for the amazing framework
- All contributors who help to improve this project
