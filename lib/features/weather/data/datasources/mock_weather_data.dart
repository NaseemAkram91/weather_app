import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_weather.dart';
import '../../domain/entities/hourly_weather.dart';
import '../../domain/entities/weather.dart';

class MockWeatherDataSource {
  Future<Weather> fetchWeather() async {
    await Future.delayed(const Duration(milliseconds: 450));
    final now = DateTime.now();

    return Weather(
      city: 'Montreal',
      country: 'US',
      updatedAt: now,
      current: const CurrentWeather(
        temperatureC: 24,
        highC: 26,
        lowC: 18,
        condition: 'Partly Cloudy',
        humidity: 54,
        windKph: 14.2,
        pressureMb: 1016,
      ),
      hourly: List.generate(8, (index) {
        final hour = now.add(Duration(hours: index + 1));
        return HourlyWeather(
          time: hour,
          temperatureC: 18.0 + index,
          condition: index.isEven ? 'Sunny' : 'Cloudy',
        );
      }),
      daily: List.generate(6, (index) {
        final day = now.add(Duration(days: index + 1));
        return DailyWeather(
          date: day,
          highC: 24.0 + index,
          lowC: 16.0 + index,
          condition: index.isEven ? 'Sunny' : 'Rain',
        );
      }),
    );
  }
}
