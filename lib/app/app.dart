import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/api_keys.dart';
import '../core/services/location_service.dart';
import '../features/weather/data/datasources/openweather_api.dart';
import '../features/weather/data/repositories/weather_repository_impl.dart';
import '../features/weather/domain/usecases/get_weather.dart';
import '../features/weather/presentation/bloc/weather_bloc.dart';
import '../features/weather/presentation/bloc/weather_event.dart';
import '../features/weather/presentation/pages/weather_page.dart';
import 'theme/app_theme.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final apiDataSource = OpenWeatherApiDataSource(
      apiKey: ApiKeys.weatherApiKey,
    );
    final locationService = LocationService();

    final repository = WeatherRepositoryImpl(
      apiDataSource: apiDataSource,
      locationService: locationService,
    );
    final getWeather = GetWeather(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherBloc(getWeather)..add(const WeatherRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        
        theme: AppTheme.light,
        home: const WeatherPage(),
      ),
    );
  }
}
