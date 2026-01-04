import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_weather.dart';
import '../../domain/entities/hourly_weather.dart';
import '../../domain/entities/weather.dart';

class OpenWeatherApiDataSource {
  final String apiKey;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  OpenWeatherApiDataSource({required this.apiKey});

  /// Fetch weather data by city name
  Future<Weather> fetchWeatherByCity(String city) async {
    // Get current weather
    final currentResponse = await http.get(
      Uri.parse('$_baseUrl/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (currentResponse.statusCode != 200) {
      throw Exception('Failed to load weather data: ${currentResponse.body}');
    }

    final currentData = json.decode(currentResponse.body);
    final lat = currentData['coord']['lat'];
    final lon = currentData['coord']['lon'];

    // Get forecast data (hourly and daily)
    return _fetchWeatherByCoords(lat, lon, currentData);
  }

  /// Fetch weather data by coordinates
  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    // Get current weather
    final currentResponse = await http.get(
      Uri.parse('$_baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (currentResponse.statusCode != 200) {
      throw Exception('Failed to load weather data: ${currentResponse.body}');
    }

    final currentData = json.decode(currentResponse.body);
    return _fetchWeatherByCoords(lat, lon, currentData);
  }

  Future<Weather> _fetchWeatherByCoords(
    double lat,
    double lon,
    Map<String, dynamic> currentData,
  ) async {
    // Get 5-day/3-hour forecast
    final forecastResponse = await http.get(
      Uri.parse('$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (forecastResponse.statusCode != 200) {
      throw Exception('Failed to load forecast data: ${forecastResponse.body}');
    }

    final forecastData = json.decode(forecastResponse.body);

    return _parseWeatherData(currentData, forecastData);
  }

  Weather _parseWeatherData(
    Map<String, dynamic> currentData,
    Map<String, dynamic> forecastData,
  ) {
    // Parse current weather
    final current = CurrentWeather(
      temperatureC: (currentData['main']['temp'] as num).toDouble(),
      highC: (currentData['main']['temp_max'] as num).toDouble(),
      lowC: (currentData['main']['temp_min'] as num).toDouble(),
      condition: currentData['weather'][0]['main'] as String,
      humidity: currentData['main']['humidity'] as int,
      windKph: ((currentData['wind']['speed'] as num).toDouble() * 3.6), // m/s to km/h
      pressureMb: (currentData['main']['pressure'] as num).toInt(),
    );

    // Parse hourly forecast (next 8 hours from 3-hour intervals)
    final List<dynamic> forecastList = forecastData['list'];
    final hourly = forecastList.take(8).map((item) {
      return HourlyWeather(
        time: DateTime.fromMillisecondsSinceEpoch((item['dt'] as int) * 1000),
        temperatureC: (item['main']['temp'] as num).toDouble(),
        condition: item['weather'][0]['main'] as String,
      );
    }).toList();

    // Parse daily forecast (get one entry per day)
    final Map<String, dynamic> dailyMap = {};
    for (final item in forecastList) {
      final date = DateTime.fromMillisecondsSinceEpoch((item['dt'] as int) * 1000);
      final dateKey = '${date.year}-${date.month}-${date.day}';

      if (!dailyMap.containsKey(dateKey)) {
        dailyMap[dateKey] = {
          'date': date,
          'high': (item['main']['temp_max'] as num).toDouble(),
          'low': (item['main']['temp_min'] as num).toDouble(),
          'condition': item['weather'][0]['main'] as String,
        };
      } else {
        final existing = dailyMap[dateKey]!;
        final tempMax = (item['main']['temp_max'] as num).toDouble();
        final tempMin = (item['main']['temp_min'] as num).toDouble();
        if (tempMax > existing['high']) existing['high'] = tempMax;
        if (tempMin < existing['low']) existing['low'] = tempMin;
      }
    }

    final daily = dailyMap.values.skip(1).take(6).map((item) {
      return DailyWeather(
        date: item['date'] as DateTime,
        highC: item['high'] as double,
        lowC: item['low'] as double,
        condition: item['condition'] as String,
      );
    }).toList();

    return Weather(
      city: currentData['name'] as String,
      country: currentData['sys']['country'] as String,
      updatedAt: DateTime.now(),
      current: current,
      hourly: hourly,
      daily: daily,
    );
  }
}
