import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherRequested extends WeatherEvent {
  const WeatherRequested();
}

class WeatherRefreshRequested extends WeatherEvent {
  const WeatherRefreshRequested();
}
