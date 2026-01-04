import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc(this.getWeather) : super(const WeatherInitial()) {
    on<WeatherRequested>(_onRequested);
    on<WeatherRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    try {
      final weather = await getWeather();
      emit(WeatherLoaded(weather));
    } catch (error) {
      emit(const WeatherFailure('Unable to load weather data'));
    }
  }

  Future<void> _onRefreshRequested(
    WeatherRefreshRequested event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final weather = await getWeather();
      emit(WeatherLoaded(weather));
    } catch (error) {
      emit(const WeatherFailure('Unable to refresh weather data'));
    }
  }
}
