import 'package:equatable/equatable.dart';

import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';

class Weather extends Equatable {
  final String city;
  final String country;
  final DateTime updatedAt;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  const Weather({
    required this.city,
    required this.country,
    required this.updatedAt,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  @override
  List<Object?> get props => [city, country, updatedAt, current, hourly, daily];
}
