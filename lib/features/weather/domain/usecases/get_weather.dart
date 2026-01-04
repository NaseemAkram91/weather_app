import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  const GetWeather(this.repository);

  Future<Weather> call() => repository.getWeather();
}
