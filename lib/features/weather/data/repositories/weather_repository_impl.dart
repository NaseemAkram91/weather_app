import '../../../../core/services/location_service.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/openweather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final OpenWeatherApiDataSource apiDataSource;
  final LocationService locationService;

  WeatherRepositoryImpl({
    required this.apiDataSource,
    required this.locationService,
  });

  @override
  Future<Weather> getWeather() async {
    try {
      // Try to get current location
      final position = await locationService.getCurrentPosition();
      return await apiDataSource.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      // Fallback to default city if location fails
      return await apiDataSource.fetchWeatherByCity('London');
    }
  }

  /// Get weather by city name
  Future<Weather> getWeatherByCity(String city) async {
    return await apiDataSource.fetchWeatherByCity(city);
  }
}
