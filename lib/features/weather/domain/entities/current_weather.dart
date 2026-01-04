import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final double temperatureC;
  final double highC;
  final double lowC;
  final String condition;
  final int humidity;
  final double windKph;
  final int pressureMb;

  const CurrentWeather({
    required this.temperatureC,
    required this.highC,
    required this.lowC,
    required this.condition,
    required this.humidity,
    required this.windKph,
    required this.pressureMb,
  });

  @override
  List<Object?> get props => [
        temperatureC,
        highC,
        lowC,
        condition,
        humidity,
        windKph,
        pressureMb,
      ];
}
