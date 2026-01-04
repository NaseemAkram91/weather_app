# Weather App 🌤️

A beautiful, modern weather application built with Flutter that provides real-time weather information with an elegant glassmorphic UI design.

## Features ✨

- **Real-time Weather Data**: Get current weather conditions using OpenWeather API
- **Location-based Forecasting**: Automatic location detection for local weather
- **Hourly Forecast**: View up to 10 hours of detailed weather predictions
- **Beautiful UI Design**:
  - Glassmorphic bottom sheet with blur effects
  - Custom curved navigation bar with unique clipper paths
  - Dynamic PNG weather icons
  - Custom gradient backgrounds
  - Smooth animations and transitions
- **Clean Architecture**: Built following BLoC pattern and clean architecture principles

## Screenshots 📱

*Add your app screenshots here*

## Tech Stack 🛠️

- **Framework**: Flutter
- **State Management**: BLoC (flutter_bloc)
- **Architecture**: Clean Architecture with feature-first structure
- **API**: OpenWeather API
- **Location Services**: Geolocator
- **HTTP Client**: Dio
- **Functional Programming**: Dartz (Either, Option)

## Project Structure 📁

```
lib/
├── app/
│   ├── app.dart                    # Main app widget
│   └── theme/
│       └── app_theme.dart          # App theme configuration
├── config/
│   └── api_keys.dart              # API keys configuration
├── core/
│   ├── constants/
│   │   └── app_sizes.dart         # UI size constants
│   ├── errors/
│   │   └── failures.dart          # Error handling
│   └── services/
│       └── location_service.dart  # Location services
└── features/
    └── weather/
        ├── data/
        │   ├── datasources/
        │   │   └── openweather_api.dart
        │   ├── models/
        │   │   └── weather_model.dart
        │   └── repositories/
        │       └── weather_repository_impl.dart
        ├── domain/
        │   ├── entities/
        │   │   ├── current_weather.dart
        │   │   ├── hourly_weather.dart
        │   │   └── weather.dart
        │   ├── repositories/
        │   │   └── weather_repository.dart
        │   └── usecases/
        │       └── get_weather.dart
        └── presentation/
            ├── bloc/
            │   ├── weather_bloc.dart
            │   ├── weather_event.dart
            │   └── weather_state.dart
            ├── pages/
            │   └── weather_page.dart
            └── widgets/
                ├── bottom_nav_bar.dart
                ├── custom_divider.dart
                ├── forecast_panel.dart
                ├── forecast_type_text.dart
                ├── hourly_card.dart
                ├── house_illustration.dart
                ├── weather_background.dart
                ├── weather_header.dart
                └── widgets.dart
```

## Getting Started 🚀

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- OpenWeather API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/NaseemAkram91/weather_app.git
   cd weather_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**

   Create a file `lib/config/api_keys.dart` and add your OpenWeather API key:
   ```dart
   class ApiKeys {
     static const String weatherApiKey = 'YOUR_API_KEY_HERE';
   }
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## API Setup 🔑

1. Get your free API key from [OpenWeather](https://openweathermap.org/api)
2. Add the API key to `lib/config/api_keys.dart`

## Dependencies 📦

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  dartz: ^0.10.1
  dio: ^5.7.0
  geolocator: ^13.0.2
  flutter_svg: ^2.0.10+1
```

## Permissions ⚠️

### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location for weather updates.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location for weather updates.</string>
```

## Architecture 🏗️

This project follows **Clean Architecture** principles with separation into three layers:

1. **Presentation Layer**: BLoC pattern for state management, UI widgets
2. **Domain Layer**: Business logic, entities, use cases, repository contracts
3. **Data Layer**: API clients, data models, repository implementations

## Features Breakdown 🎯

### Weather Data
- Current temperature and conditions
- High/Low temperature
- City name
- Weather condition description
- Hourly forecast (10 hours)
- Real-time location-based weather

### UI Components
- **Weather Header**: Displays city, temperature (°C), and conditions with custom styling
- **House Illustration**: Dynamic weather-based illustration
- **Forecast Panel**: Glassmorphic bottom sheet with blur effects and gradient
- **Hourly Cards**: Individual hour cards with PNG icons, time (12-hour format), and temperature
- **Custom Navigation Bar**: Unique curved design with custom clippers and gradient
- **Weather Background**: Dynamic background image with full coverage

### Time Format
- Displays time in 12-hour format (e.g., "2 AM", "9 PM")
- First card shows "Now" for current hour

## Customization 🎨

### Colors
Modify gradient colors in:
- `lib/features/weather/presentation/widgets/forecast_panel.dart`
- `lib/features/weather/presentation/widgets/bottom_nav_bar.dart`

### Weather Icons
Replace PNG icons in `assets/icons/`:
- `sunny.png` - Clear/sunny weather
- `cloudy.png` - Cloudy conditions
- `rainy.png` - Rain/drizzle
- `stormy.png` - Thunderstorms
- `snowy.png` - Snow
- `partly_cloudy.png` - Partly cloudy
- `clear.png` - Clear night

### Background
Replace background image:
- `assets/Image.png` - Main background image

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments 👏

- Weather data provided by [OpenWeather API](https://openweathermap.org/)
- UI design with glassmorphism effects
- Custom navigation bar with clipper paths

## Contact 📧

Naseem Akram - [@NaseemAkram91](https://github.com/NaseemAkram91)

Project Link: [https://github.com/NaseemAkram91/weather_app](https://github.com/NaseemAkram91/weather_app)

---

Made with ❤️ using Flutter
