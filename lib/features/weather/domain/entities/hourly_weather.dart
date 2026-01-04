import 'package:equatable/equatable.dart';

class HourlyWeather extends Equatable {
  final DateTime time;
  final double temperatureC;
  final String condition;

  const HourlyWeather({
    required this.time,
    required this.temperatureC,
    required this.condition,
  });

  @override
  List<Object?> get props => [time, temperatureC, condition];
}
